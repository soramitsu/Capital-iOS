/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood
import SoraFoundation


final class ContactsPresenter: NSObject {
    
    private struct Constants {
        static let inputSearchDelay: Double = 0.5
    }

    private enum DataLoadingState {
        case waitingCache
        case refreshing
        case refreshed
    }
    
    weak var view: ContactsViewProtocol?
    var coordinator: ContactsCoordinatorProtocol
    
    private(set) var viewModel = ContactListViewModel()
    private(set) var actionsSection: ContactSectionViewModelProtocol?

    private let dataProvider: SingleValueProvider<[SearchData]>
    private let walletService: WalletServiceProtocol
    private let listViewModelFactory: ContactsListViewModelFactoryProtocol
    private let currentAccountId: String
    private let localSearchEngine: ContactsLocalSearchEngineProtocol?
    private let commandFactory: WalletCommandFactoryProtocol
    private let canFindItself: Bool

    private let selectedAsset: WalletAsset

    private var searchPattern = ""

    private var contactsLoadingState: DataLoadingState = .waitingCache

    private var searchOperation: CancellableCall?
    private var isWaitingSearch: Bool = false

    private var moduleParameters: ContactModuleParameters {
        ContactModuleParameters(accountId: currentAccountId,
                                assetId: selectedAsset.identifier)
    }
    
    var logger: WalletLoggerProtocol?

    deinit {
        cancelSearch()
    }

    init(view: ContactsViewProtocol,
         coordinator: ContactsCoordinatorProtocol,
         commandFactory: WalletCommandFactoryProtocol,
         dataProvider: SingleValueProvider<[SearchData]>,
         walletService: WalletServiceProtocol,
         listViewModelFactory: ContactsListViewModelFactoryProtocol,
         selectedAsset: WalletAsset,
         currentAccountId: String,
         localSearchEngine: ContactsLocalSearchEngineProtocol?,
         canFindItself: Bool) {
        self.view = view
        self.coordinator = coordinator
        self.commandFactory = commandFactory
        self.dataProvider = dataProvider
        self.walletService = walletService
        self.listViewModelFactory = listViewModelFactory
        self.selectedAsset = selectedAsset
        self.currentAccountId = currentAccountId
        self.localSearchEngine = localSearchEngine
        self.canFindItself = canFindItself
    }

    private func setupViewModelActions() {
        let locale = localizationManager?.selectedLocale ?? Locale.current
        viewModel.contacts = listViewModelFactory
            .createContactViewModelListFromItems([],
                                                 parameters: moduleParameters,
                                                 locale: locale,
                                                 delegate: self,
                                                 commandFactory: commandFactory)
    }

    private func provideBarActionViewModel() {
        let locale = localizationManager?.selectedLocale ?? Locale.current
        if let viewModel = listViewModelFactory
            .createBarActionForAccountId(moduleParameters,
                                         locale: locale,
                                         commandFactory: commandFactory) {
            view?.set(barViewModel: viewModel)
        }
    }

    private func setupDataProvider() {
        let changesBlock = { [weak self] (changes: [DataProviderChange<[SearchData]>]) -> Void in
            if let change = changes.first {
                switch change {
                case .insert(let items), .update(let items):
                    self?.handleContacts(with: items)
                default:
                    break
                }
            } else {
                self?.handleContacts(with: nil)
            }
        }
        
        let failBlock: (Error) -> Void = { [weak self] (error: Error) in
            self?.logger?.error("Unexpected search data provider error: \(error)")
        }
        
        dataProvider.addObserver(self,
                                 deliverOn: .main,
                                 executing: changesBlock,
                                 failing: failBlock,
                                 options: DataProviderObserverOptions(alwaysNotifyOnRefresh: true))
    }
    
    private func handleContacts(with updatedContacts: [SearchData]?) {
        if let contacts = updatedContacts {
            let items = contacts.filter {
                $0.accountId != currentAccountId
            }

            let locale = localizationManager?.selectedLocale ?? Locale.current

            viewModel.contacts = listViewModelFactory
                .createContactViewModelListFromItems(items,
                                                     parameters: moduleParameters,
                                                     locale: locale,
                                                     delegate: self,
                                                     commandFactory: commandFactory)
        }

        switch contactsLoadingState {
        case .waitingCache:
            contactsLoadingState = .refreshing
            dataProvider.refresh()
        case .refreshing:
            contactsLoadingState = .refreshed
        case .refreshed:
            break
        }

        if viewModel.state == .full {
            switchViewModel(to: .full)
        }
    }

    private func handleSearch(with foundData: [SearchData]) {
        let filtered: [SearchData]

        if canFindItself {
            filtered = foundData
        } else {
            filtered = foundData.filter { $0.accountId != currentAccountId }
        }

        let locale = localizationManager?.selectedLocale ?? Locale.current
        viewModel.found = listViewModelFactory
            .createSearchViewModelListFromItems(filtered,
                                                parameters: moduleParameters,
                                                locale: locale,
                                                delegate: self,
                                                commandFactory: commandFactory)

        switchViewModel(to: .search)
    }

    private func switchViewModel(to state: ContactListState) {
        viewModel.state = state

        switch state {
        case .search:
            viewModel.shouldDisplayEmptyState = true
        case .full:
            viewModel.shouldDisplayEmptyState = contactsLoadingState == .refreshed
        }

        view?.set(listViewModel: viewModel)
    }
    
    private func cancelSearch() {
        if isWaitingSearch {
            view?.didStopSearch()

            NSObject.cancelPreviousPerformRequests(withTarget: self,
                                                   selector: #selector(performSearch),
                                                   object: nil)
            isWaitingSearch = false
        }

        searchOperation?.cancel()
        searchOperation = nil
    }
    
    private func scheduleSearch() {
        searchOperation?.cancel()
        searchOperation = nil

        let parameters = ContactModuleParameters(accountId: currentAccountId,
                                                 assetId: selectedAsset.identifier)
        let locale = localizationManager?.selectedLocale ?? Locale.current

        if let localSearchResults = localSearchEngine?.search(query: searchPattern,
                                                              parameters: parameters,
                                                              locale: locale,
                                                              delegate: self,
                                                              commandFactory: commandFactory) {
            if isWaitingSearch {
                cancelSearch()
            }

            viewModel.found = localSearchResults

            switchViewModel(to: .search)

            return
        }

        if !isWaitingSearch {
            view?.didStartSearch()

            isWaitingSearch = true

            self.perform(#selector(performSearch), with: nil,
                         afterDelay: Constants.inputSearchDelay)
        }
    }
    
    @objc private func performSearch() {
        isWaitingSearch = false

        searchOperation = walletService.search(for: searchPattern, runCompletionIn: .main) { [weak self] (result) in

            guard let strongSelf = self else {
                return
            }

            if !strongSelf.isWaitingSearch {
                strongSelf.view?.didStopSearch()
            }

            if let result = result {
                self?.searchOperation = nil

                switch result {
                case .success(let contacts):
                    let loadedContacts = contacts ?? []
                    strongSelf.handleSearch(with: loadedContacts)
                case .failure(let error):
                    strongSelf.handleSearchError(error)
                }
            }
        }
    }

    private func handleSearchError(_ error: Error) {
        guard let view = view else {
            logger?.error(error.localizedDescription)
            return
        }

        let locale = localizationManager?.selectedLocale
        if !view.attemptShowError(error, locale: locale) {
            logger?.error(error.localizedDescription)
        }
    }
    
}


extension ContactsPresenter: ContactsPresenterProtocol {
    
    func setup() {
        setupViewModelActions()
        view?.set(listViewModel: viewModel)

        provideBarActionViewModel()
        
        setupDataProvider()
    }
    
    func search(_ pattern: String) {
        searchPattern = pattern
        
        guard !pattern.isEmpty else {
            cancelSearch()

            switchViewModel(to: .full)

            return
        }

        scheduleSearch()
    }
    
}

extension ContactsPresenter: ContactViewModelDelegate {
    
    func didSelect(contact: ContactViewModelProtocol) {
        let receiveInfo = ReceiveInfo(accountId: contact.accountId,
                                      assetId: selectedAsset.identifier,
                                      amount: nil,
                                      details: nil)

        let payload = TransferPayload(receiveInfo: receiveInfo,
                                      receiverName: contact.name)

        coordinator.send(to: payload)
    }
    
}

extension ContactsPresenter: Localizable {
    func applyLocalization() {
        if view?.isSetup == true {
            setupViewModelActions()
            view?.set(listViewModel: viewModel)

            provideBarActionViewModel()
        }
    }
}
