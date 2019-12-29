/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood
import IrohaCommunication
import SoraFoundation


final class HistoryPresenter {

    enum DataState {
        case waitingCached
        case loading(page: OffsetPagination, previousPage: OffsetPagination?)
        case loaded(page: OffsetPagination?, canLoadMore: Bool)
        case filtering(page: OffsetPagination, previousPage: OffsetPagination?)
        case filtered(page: OffsetPagination?, canLoadMore: Bool)
    }

    weak var view: HistoryViewProtocol?
    let coordinator: HistoryCoordinatorProtocol
    let dataProvider: SingleValueProvider<AssetTransactionPageData>
    let walletService: WalletServiceProtocol
    let eventCenter: WalletEventCenterProtocol
    var viewModelFactory: HistoryViewModelFactoryProtocol
    var transactionsPerPage: Int = 100
    let assets: [WalletAsset]
    var filter = WalletHistoryRequest()
    var initialFilter: WalletHistoryRequest

    private(set) var dataLoadingState: DataState = .waitingCached
    private(set) var viewModels: [TransactionSectionViewModel] = []
    private(set) var pages: [AssetTransactionPageData] = []

    var logger: WalletLoggerProtocol?

    init(view: HistoryViewProtocol,
         coordinator: HistoryCoordinatorProtocol,
         dataProvider: SingleValueProvider<AssetTransactionPageData>,
         walletService: WalletServiceProtocol,
         eventCenter: WalletEventCenterProtocol,
         viewModelFactory: HistoryViewModelFactoryProtocol,
         assets: [WalletAsset],
         transactionsPerPage: Int) {
        self.view = view
        self.coordinator = coordinator
        self.dataProvider = dataProvider
        self.walletService = walletService
        self.viewModelFactory = viewModelFactory
        self.transactionsPerPage = transactionsPerPage
        self.assets = assets
        self.eventCenter = eventCenter

        let assetIds = assets.map { $0.identifier }
        filter.assets = assetIds
        initialFilter = WalletHistoryRequest(assets: assetIds)
    }
    
    private func reloadView(with pageData: AssetTransactionPageData, andSwitch newDataLoadingState: DataState) throws {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        var viewModels = [TransactionSectionViewModel]()
        _ = try viewModelFactory.merge(newItems: pageData.transactions,
                                       into: &viewModels,
                                       locale: locale)

        self.dataLoadingState = newDataLoadingState
        self.pages = [pageData]
        self.viewModels = viewModels

        view?.reloadContent()
    }

    private func reloadView() throws {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        var viewModels = [TransactionSectionViewModel]()

        for page in pages {
            _ = try viewModelFactory.merge(newItems: page.transactions,
                                           into: &viewModels,
                                           locale: locale)
        }

        self.viewModels = viewModels

        view?.reloadContent()
    }

    private func resetView(with newState: DataState) {
        dataLoadingState = newState
        pages = []
        viewModels = []
        view?.reloadContent()
    }

    private func appendPage(with pageData: AssetTransactionPageData, andSwitch newDataLoadingState: DataState) throws {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        var viewModels = self.viewModels
        let viewChanges = try viewModelFactory.merge(newItems: pageData.transactions,
                                                     into: &viewModels,
                                                     locale: locale)

        self.dataLoadingState = newDataLoadingState
        self.pages.append(pageData)
        self.viewModels = viewModels

        view?.handle(changes: viewChanges)
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
        dataProvider.addObserver(self,
                                 deliverOn: .main,
                                 executing: changesBlock,
                                 failing: failBlock,
                                 options: options)
    }

    private func clearDataProvider() {
        dataProvider.removeObserver(self)
    }

    private func loadTransactions(for pagination: OffsetPagination) {
        walletService.fetchTransactionHistory(for: filter,
                                              pagination: pagination,
                                              runCompletionIn: .main) { [weak self] (optionalResult) in
                                                    if let result = optionalResult {
                                                        switch result {
                                                        case .success(let pageData):
                                                            let loadedData = pageData ??
                                                                AssetTransactionPageData(transactions: [])
                                                            self?.handleNext(transactionData: loadedData,
                                                                             for: pagination)
                                                        case .failure(let error):
                                                            self?.handleNext(error: error, for: pagination)
                                                        }
                                                    }
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
        default: break
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
        default: break
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
        case .loaded, .filtered:
            logger?.debug("Page offset \(pagination.offset) loaded but not expected")
        case .filtering(let page, _):
            if page.offset == pagination.offset {
                do {
                    let loadedPage = OffsetPagination(offset: pagination.offset,
                                                      count: transactionData.transactions.count)
                    let newState = DataState.filtered(page: pagination,
                                                      canLoadMore: loadedPage.count == transactionsPerPage)
                    try appendPage(with: transactionData,
                                   andSwitch: newState)
                } catch {
                    logger?.error("Did receive page processing error \(error)")
                }
            } else {
                logger?.debug("Unexpected loaded page offset \(pagination.offset) but expected \(page.offset)")
            }
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
        case .filtering(let currentPage, let previousPage):
            if currentPage.offset == pagination.offset {
                logger?.debug("Loading page \(pagination) failed")
                
                dataLoadingState = .filtered(page: previousPage, canLoadMore: true)
            } else {
                logger?.debug("Loading offset \(pagination.offset) failed \(error) but expecting \(currentPage.offset)")
            }
        case .loaded, .filtered:
            logger?.debug("Loading page offset \(pagination.offset) failed \(error) but not expected")
        }
    }
}


extension HistoryPresenter: HistoryPresenterProtocol {
    
    func setup() {
        viewModelFactory.delegate = self

        setupDataProvider()

        eventCenter.add(observer: self)
    }

    func reloadCache() {
        if case .loaded = dataLoadingState {
            dataProvider.refresh()
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
        case .filtering(_, let previousPage):
            if previousPage == nil {
                return
            }
        default:
            break
        }

        dataLoadingState = .loading(page: OffsetPagination(offset: 0, count: transactionsPerPage),
                                    previousPage: nil)

        dataProvider.refresh()
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
        case .filtering(_, let previousPage):
            return previousPage != nil
        case .filtered(let page, let canLoadMore):
            if let currentPage = page, canLoadMore {
                let nextPage: OffsetPagination
                
                nextPage = OffsetPagination(offset: currentPage.offset + currentPage.count,
                                            count: transactionsPerPage)
                
                dataLoadingState = .filtering(page: nextPage, previousPage: currentPage)
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

    func showTransaction(at index: Int, in section: Int) {
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
    
    func showFilter() {
        coordinator.presentFilter(filter: filter, assets: assets)
    }
    
}


extension HistoryPresenter: HistoryCoordinatorDelegate {
    
    func coordinator(_ coordinator: HistoryCoordinatorProtocol, didReceive filter: WalletHistoryRequest) {
        if filter != self.filter {
            self.filter = filter

            clearDataProvider()

            guard filter != initialFilter else {
                dataLoadingState = .waitingCached
                setupDataProvider()
                return
            }

            let pagination = OffsetPagination(offset: 0, count: transactionsPerPage)
            resetView(with: .filtering(page: pagination, previousPage: nil))
            loadTransactions(for: pagination)
        }
    }
    
}

extension HistoryPresenter: HistoryViewModelFactoryDelegate {
    func historyViewModelFactoryDidChange(_ factory: HistoryViewModelFactoryProtocol) {
        do {
            try reloadView()
        } catch {
            logger?.error("Can't reload view when view model factory changed \(error)")
        }
    }
}

extension HistoryPresenter: WalletEventVisitorProtocol {
    func processTransferComplete(event: TransferCompleteEvent) {
        dataProvider.refresh()
    }

    func processWithdrawComplete(event: WithdrawCompleteEvent) {
        dataProvider.refresh()
    }

    func processAccountUpdate(event: AccountUpdateEvent) {
        dataProvider.refresh()
    }
}

extension HistoryPresenter: Localizable {
    func applyLocalization() {
        if view?.isSetup == true {
            do {
                try reloadView()
            } catch {
                logger?.error("Can't reload after language switch due to error \(error)")
            }
        }
    }
}
