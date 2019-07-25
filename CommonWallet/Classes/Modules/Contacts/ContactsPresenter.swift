import Foundation
import RobinHood
import IrohaCommunication


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
    private let dataProvider: SingleValueProvider<[SearchData], CDCWSingleValue>
    private let walletService: WalletServiceProtocol
    private let viewModelFactory: ContactsViewModelFactoryProtocol
    private let currentAccountId: IRAccountId

    private let selectedAsset: WalletAsset

    private var searchPattern = ""

    private var contactsLoadingState: DataLoadingState = .waitingCache

    private var searchOperation: Operation?
    private var isWaitingSearch: Bool = false
    
    var logger: WalletLoggerProtocol?

    deinit {
        cancelSearch()
    }

    init(view: ContactsViewProtocol,
         coordinator: ContactsCoordinatorProtocol,
         dataProvider: SingleValueProvider<[SearchData], CDCWSingleValue>,
         walletService: WalletServiceProtocol,
         viewModelFactory: ContactsViewModelFactoryProtocol,
         selectedAsset: WalletAsset,
         currentAccountId: IRAccountId) {
        self.view = view
        self.coordinator = coordinator
        self.dataProvider = dataProvider
        self.walletService = walletService
        self.viewModelFactory = viewModelFactory
        self.selectedAsset = selectedAsset
        self.currentAccountId = currentAccountId
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
        
        dataProvider.addCacheObserver(self,
                                      deliverOn: .main,
                                      executing: changesBlock,
                                      failing: failBlock,
                                      options: DataProviderObserverOptions(alwaysNotifyOnRefresh: true))
    }
    
    private func handleContacts(with updatedContacts: [SearchData]?) {
        if let contacts = updatedContacts {
            viewModel.contacts = contacts.filter {
                $0.accountId != currentAccountId.identifier()
            }.map {
                viewModelFactory.createContactViewModel(from: $0, delegate: self)
            }
        }

        switch contactsLoadingState {
        case .waitingCache:
            contactsLoadingState = .refreshing
            dataProvider.refreshCache()
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
        viewModel.found = foundData.filter {
            $0.accountId != currentAccountId.identifier()
        }.map {
            viewModelFactory.createContactViewModel(from: $0, delegate: self)
        }

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

        view?.set(viewModel: viewModel)
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
            if self?.isWaitingSearch == false {
                self?.view?.didStopSearch()
            }

            if let result = result {
                self?.searchOperation = nil

                switch result {
                case .success(let contacts): self?.handleSearch(with: contacts)
                case .error(let error):      self?.logger?.error(error.localizedDescription)
                }
            }
        }
    }
    
}


extension ContactsPresenter: ContactsPresenterProtocol {
    
    func setup() {
        viewModel.actions.append(viewModelFactory.createScanViewModel(delegate: self))
        view?.set(viewModel: viewModel)
        
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
    
    func dismiss() {
        coordinator.dismiss()
    }
    
}


extension ContactsPresenter: ScanCodeViewModelDelegate {
    
    func scanCode() {
        coordinator.scanInvoice()
    }
    
}


extension ContactsPresenter: ContactViewModelDelegate {
    
    func didSelect(contact: ContactViewModelProtocol) {
        guard let accountId = try? IRAccountIdFactory.account(withIdentifier: contact.accountId) else {
            return
        }

        let receiveInfo = ReceiveInfo(accountId: accountId,
                                      assetId: selectedAsset.identifier,
                                      amount: nil,
                                      details: nil)

        let payload = AmountPayload(receiveInfo: receiveInfo,
                                    receiverName: contact.name)

        coordinator.send(to: payload)
    }
    
}
