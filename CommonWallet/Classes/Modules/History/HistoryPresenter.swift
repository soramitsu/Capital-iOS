/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood
import IrohaCommunication

final class HistoryPresenter {
    enum DataState {
        case waitingCached
        case loading(page: OffsetPagination, previousPage: OffsetPagination?)
        case loaded(page: OffsetPagination?, canLoadMore: Bool)
    }

    weak var view: HistoryViewProtocol?
    var coordinator: HistoryCoordinatorProtocol
    var dataProvider: SingleValueProvider<AssetTransactionPageData, CDCWSingleValue>
    var walletService: WalletServiceProtocol
    var viewModelFactory: HistoryViewModelFactoryProtocol
    var assets: [IRAssetId]
    var transactionsPerPage: Int = 100

    private(set) var dataLoadingState: DataState = .waitingCached
    private(set) var viewModels: [TransactionSectionViewModel] = []
    private(set) var pages: [AssetTransactionPageData] = []

    var logger: WalletLoggerProtocol?

    init(view: HistoryViewProtocol,
         coordinator: HistoryCoordinatorProtocol,
         dataProvider: SingleValueProvider<AssetTransactionPageData, CDCWSingleValue>,
         walletService: WalletServiceProtocol,
         viewModelFactory: HistoryViewModelFactoryProtocol,
         assets: [IRAssetId],
         transactionsPerPage: Int) {
        self.view = view
        self.coordinator = coordinator
        self.dataProvider = dataProvider
        self.walletService = walletService
        self.viewModelFactory = viewModelFactory
        self.assets = assets
        self.transactionsPerPage = transactionsPerPage
    }
    
    private func reloadView(with pageData: AssetTransactionPageData, andSwitch newDataLoadingState: DataState) throws {
        var viewModels = [TransactionSectionViewModel]()
        _ = try viewModelFactory.merge(newItems: pageData.transactions, into: &viewModels)

        self.dataLoadingState = newDataLoadingState
        self.pages = [pageData]
        self.viewModels = viewModels

        view?.didReload()
    }

    private func appendPage(with pageData: AssetTransactionPageData, andSwitch newDataLoadingState: DataState) throws {
        var viewModels = self.viewModels
        let viewChanges = try viewModelFactory.merge(newItems: pageData.transactions, into: &viewModels)

        self.dataLoadingState = newDataLoadingState
        self.pages.append(pageData)
        self.viewModels = viewModels

        view?.didReceive(changes: viewChanges)
    }
    
    private func setupDataProvider() {
        let changesBlock = { [weak self] (changes: [DataProviderChange<AssetTransactionPageData>]) -> Void in
            if let change = changes.first {
                switch change {
                case .insert(let item), .update(let item):
                    self?.handleDataProvider(transactionData: item)
                default:
                    break
                }
            } else {
                self?.handleDataProvider(transactionData: nil)
            }
        }

        let failBlock: (Error) -> Void = { [weak self] (error: Error) in
            self?.handleDataProvider(error: error)
        }

        let options = DataProviderObserverOptions(alwaysNotifyOnRefresh: true)
        dataProvider.addCacheObserver(self,
                                      deliverOn: .main,
                                      executing: changesBlock,
                                      failing: failBlock,
                                      options: options)
    }

    private func loadTransactions(for pagination: OffsetPagination) {
        do {
            _ = try walletService.fetchTransactionHistory(for: assets,
                                                          pagination: pagination,
                                                          runCompletionIn: .main) { [weak self] (optionalResult) in
                if let result = optionalResult {
                    switch result {
                    case .success(let pageData):
                        self?.handleNext(transactionData: pageData, for: pagination)
                    case .error(let error):
                        self?.handleNext(error: error, for: pagination)
                    }
                }
            }
        } catch {
            handleNext(error: error, for: pagination)
        }
    }

    private func handleDataProvider(transactionData: AssetTransactionPageData?) {
        switch dataLoadingState {
        case .waitingCached:
            do {
                let loadedTransactionData = transactionData ?? AssetTransactionPageData(transactions: [])

                let loadedPage = OffsetPagination(offset: 0, count: loadedTransactionData.transactions.count)
                let newState = DataState.loaded(page: loadedPage, canLoadMore: false)
                try reloadView(with: loadedTransactionData,
                               andSwitch: newState)
                reload()
            } catch {
                logger?.error("Did receive cache processing error \(error)")
            }
        case .loading, .loaded:
            do {
                if let transactionData = transactionData {
                    let loadedPage = OffsetPagination(offset: 0, count: transactionData.transactions.count)
                    let newState = DataState.loaded(page: loadedPage,
                                                    canLoadMore: loadedPage.count == transactionsPerPage)
                    try reloadView(with: transactionData,
                                   andSwitch: newState)
                } else if pages.count > 0 {
                    let loadedPage = OffsetPagination(offset: 0, count: pages[0].transactions.count)
                    let newState = DataState.loaded(page: loadedPage,
                                                    canLoadMore: loadedPage.count == transactionsPerPage)
                    try reloadView(with: pages[0], andSwitch: newState)
                } else {
                    logger?.error("Inconsistent data loading before cache")
                }
            } catch {
                logger?.debug("Did receive cache update processing error \(error)")
            }
        }
    }

    private func handleDataProvider(error: Error) {
        switch dataLoadingState {
        case .waitingCached:
            logger?.error("Cache unexpectedly failed \(error)")
        case .loading:
            if pages.count > 0 {
                do {
                    let loadedPage = OffsetPagination(offset: 0, count: pages[0].transactions.count)
                    try reloadView(with: pages[0], andSwitch: .loaded(page: loadedPage, canLoadMore: false))
                } catch {
                    logger?.error("Did receive cache processing error \(error)")
                }
            }

            logger?.debug("Cache refresh failed \(error)")
        case .loaded:
            logger?.debug("Unexpected loading failed \(error)")
        }
    }

    private func handleNext(transactionData: AssetTransactionPageData, for pagination: OffsetPagination) {
        switch dataLoadingState {
        case .waitingCached:
            logger?.error("Unexpected page loading before cache")
        case .loading(let currentPage, _):
            if currentPage.offset == pagination.offset {
                do {
                    let loadedPage = OffsetPagination(offset: pagination.offset,
                                                      count: transactionData.transactions.count)
                    let newState = DataState.loaded(page: pagination,
                                                    canLoadMore: loadedPage.count == transactionsPerPage)
                    try appendPage(with: transactionData,
                                   andSwitch: newState)
                } catch {
                    logger?.error("Did receive page processing error \(error)")
                }
            } else {
                logger?.debug("Unexpected loaded page offset \(pagination.offset) but expected \(currentPage.offset)")
            }
        case .loaded:
            logger?.debug("Page offset \(pagination.offset) loaded but not expected")
        }
    }

    private func handleNext(error: Error, for pagination: OffsetPagination) {
        switch dataLoadingState {
        case .waitingCached:
            logger?.error("Cached data expected but received page error \(error)")
        case .loading(let currentPage, let previousPage):
            if currentPage.offset == pagination.offset {
                logger?.debug("Loading page \(pagination) failed")

                dataLoadingState = .loaded(page: previousPage, canLoadMore: true)
            } else {
                logger?.debug("Loading offset \(pagination.offset) failed \(error) but expecting \(currentPage.offset)")
            }
        case .loaded:
            logger?.debug("Loading page offset \(pagination.offset) failed \(error) but not expected")
        }
    }
}

extension HistoryPresenter: HistoryPresenterProtocol {
    func setup() {
        setupDataProvider()
    }

    func viewDidAppear() {
        if case .loaded = dataLoadingState {
            dataProvider.refreshCache()
        }
    }

    func reload() {
        switch dataLoadingState {
        case .waitingCached:
            return
        case .loading(_, let previousPage):
            if previousPage == nil {
                return
            }
        default:
            break
        }

        dataLoadingState = .loading(page: OffsetPagination(offset: 0, count: transactionsPerPage),
                                    previousPage: nil)

        dataProvider.refreshCache()
    }

    func loadNext() -> Bool {
        switch dataLoadingState {
        case .waitingCached:
            return false
        case .loading(_, let previousPage):
            return previousPage != nil
        case .loaded(let currentPage, let canLoadMore):
            if let currentPage = currentPage, canLoadMore {
                let nextPage: OffsetPagination

                nextPage = OffsetPagination(offset: currentPage.offset + currentPage.count,
                                            count: transactionsPerPage)

                dataLoadingState = .loading(page: nextPage, previousPage: currentPage)
                loadTransactions(for: nextPage)

                return true
            } else {
                return false
            }
        }
    }

    func numberOfSections() -> Int {
        return viewModels.count
    }

    func sectionModel(at index: Int) -> TransactionSectionViewModelProtocol {
        return viewModels[index]
    }

    func didSelectModel(at index: Int, in section: Int) {
        let viewModel = viewModels[section].items[index]

        var optionalTransaction: AssetTransactionData?

        for page in pages {
            if let transation = page.transactions.first(where: {$0.transactionId == viewModel.transactionId}) {
                optionalTransaction = transation
                break
            }
        }

        if let transaction = optionalTransaction {
            coordinator.presentDetails(for: transaction)
        }
    }
}
