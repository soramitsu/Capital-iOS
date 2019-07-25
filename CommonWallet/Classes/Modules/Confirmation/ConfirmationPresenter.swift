import Foundation
import IrohaCommunication
import RobinHood


final class ConfirmationPresenter {
    weak var view: WalletFormViewProtocol?
    var coordinator: ConfirmationCoordinatorProtocol
    
    private let payload: TransferPayload
    private let service: WalletServiceProtocol
    private let resolver: ResolverProtocol
    private let accessoryViewModelFactory: ContactAccessoryViewModelFactoryProtocol
    
    var logger: WalletLoggerProtocol?

    init(view: WalletFormViewProtocol,
         coordinator: ConfirmationCoordinatorProtocol,
         service: WalletServiceProtocol,
         resolver: ResolverProtocol,
         payload: TransferPayload,
         accessoryViewModelFactory: ContactAccessoryViewModelFactoryProtocol) {
        self.view = view
        self.coordinator = coordinator
        self.service = service
        self.payload = payload
        self.resolver = resolver
        self.accessoryViewModelFactory = accessoryViewModelFactory
    }

    private func handleTransfer(result: OperationResult<Bool>) {
        switch result {
        case .success:
            coordinator.showResult(payload: payload)
        case .error:
            view?.showError(message: "Transaction failed. Please, try again later.")
        }
    }

    func provideMainViewModels() {
        var viewModels: [WalletFormViewModel] = []

        viewModels.append(WalletFormViewModel(layoutType: .accessory,
                                              title: "Please check and confirm details",
                                              details: nil))

        let amount: String
        if let decimalAmount = Decimal(string: payload.transferInfo.amount.value),
            let formattedAmount = resolver.amountFormatter.string(from: decimalAmount as NSNumber) {
            amount = "\(payload.assetSymbol)\(formattedAmount)"
        } else {
            amount = "\(payload.assetSymbol)\(payload.transferInfo.amount.value)"
        }

        viewModels.append(WalletFormViewModel(layoutType: .accessory, title: "Amount",
                                              details: amount,
                                              icon: resolver.style.amountChangeStyle.decrease))

        if !payload.transferInfo.details.isEmpty {
            viewModels.append(WalletFormViewModel(layoutType: .details,
                                                  title: "Description",
                                                  details: payload.transferInfo.details))
        }

        view?.didReceive(viewModels: viewModels)
    }

    func provideAccessoryViewModel() {
        let viewModel = accessoryViewModelFactory.createViewModel(from: payload.receiverName,
                                                                  fullName: payload.receiverName,
                                                                  action: "Next")
        view?.didReceive(accessoryViewModel: viewModel)
    }
}


extension ConfirmationPresenter: ConfirmationPresenterProtocol {
    
    func setup() {
        provideMainViewModels()
        provideAccessoryViewModel()
    }
    
    func performAction() {
        view?.didStartLoading()

        service.transfer(info: payload.transferInfo, runCompletionIn: .main) { [weak self] (optionalResult) in
            self?.view?.didStopLoading()

            if let result = optionalResult {
                self?.handleTransfer(result: result)
            }
        }
    }
}
