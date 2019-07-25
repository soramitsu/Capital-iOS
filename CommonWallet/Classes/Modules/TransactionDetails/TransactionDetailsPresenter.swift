import Foundation
import IrohaCommunication


final class TransactionDetailsPresenter {
    weak var view: WalletFormViewProtocol?
    var coordinator: TransactionDetailsCoordinatorProtocol

    private(set) var resolver: ResolverProtocol
    private(set) var transactionData: AssetTransactionData

    init(view: WalletFormViewProtocol,
         coordinator: TransactionDetailsCoordinatorProtocol,
         resolver: ResolverProtocol,
         transactionData: AssetTransactionData) {
        self.view = view
        self.coordinator = coordinator
        self.resolver = resolver
        self.transactionData = transactionData
    }

    private func createStatusViewModel(for status: AssetTransactionStatus) -> WalletFormViewModel {
        switch status {
        case .commited:
            return WalletFormViewModel(layoutType: .accessory,
                                       title: "Status",
                                       details: "Success",
                                       detailsColor: resolver.style.statusStyleContainer.approved.color,
                                       icon: resolver.style.statusStyleContainer.approved.icon)
        case .pending:
            return WalletFormViewModel(layoutType: .accessory,
                                       title: "Status",
                                       details: "Pending",
                                       detailsColor: resolver.style.statusStyleContainer.pending.color,
                                       icon: resolver.style.statusStyleContainer.pending.icon)
        case .rejected:
            return WalletFormViewModel(layoutType: .accessory,
                                       title: "Status",
                                       details: "Rejected",
                                       detailsColor: resolver.style.statusStyleContainer.rejected.color,
                                       icon: resolver.style.statusStyleContainer.rejected.icon)
        }
    }

    private func createAmountViewModel(for amountString: String) -> WalletFormViewModel {
        let asset = resolver.account.assets.first {
            $0.identifier.identifier() == transactionData.assetId
        }

        let assetSymbol = asset?.symbol ?? ""

        let details = assetSymbol + amountString

        let icon = transactionData.incoming ? resolver.style.amountChangeStyle.increase
            : resolver.style.amountChangeStyle.decrease

        return WalletFormViewModel(layoutType: .accessory,
                                   title: "Amount",
                                   details: details,
                                   icon: icon)
    }

    private func updateView() {
        var viewModels = [WalletFormViewModel]()

        let idViewModel = WalletFormViewModel(layoutType: .accessory,
                                              title: "Identifier",
                                              details: transactionData.displayIdentifier)
        viewModels.append(idViewModel)

        let statusViewModel: WalletFormViewModel = createStatusViewModel(for: transactionData.status)
        viewModels.append(statusViewModel)

        if transactionData.status == .rejected, let reason = transactionData.reason {
            let reasonViewModel = WalletFormViewModel(layoutType: .details,
                                                      title: "Reason",
                                                      details: reason)
            viewModels.append(reasonViewModel)
        }

        let transactionDate = Date(timeIntervalSince1970: TimeInterval(transactionData.timestamp))
        let timeViewModel = WalletFormViewModel(layoutType: .accessory,
                                                title: "Date and Time",
                                                details: resolver.statusDateFormatter.string(from: transactionDate))
        viewModels.append(timeViewModel)

        let type = transactionData.incoming ? "Receive" : "Send"
        let typeViewModel = WalletFormViewModel(layoutType: .accessory,
                                                title: "Type",
                                                details: type)
        viewModels.append(typeViewModel)

        let peerTitle = transactionData.incoming ? "Sender" : "Recipient"
        let receiverViewModel = WalletFormViewModel(layoutType: .accessory,
                                                    title: peerTitle,
                                                    details: transactionData.peerName)
        viewModels.append(receiverViewModel)

        if let amount = Decimal(string: transactionData.amount),
            let amountString = resolver.amountFormatter.string(from: amount as NSNumber) {

            let amountViewModel = createAmountViewModel(for: amountString)

            viewModels.append(amountViewModel)
        }

        if !transactionData.details.isEmpty {
            let descriptionViewModel = WalletFormViewModel(layoutType: .details,
                                                           title: "Description",
                                                           details: transactionData.details)

            viewModels.append(descriptionViewModel)
        }

        view?.didReceive(viewModels: viewModels)
    }
}


extension TransactionDetailsPresenter: TransactionDetailsPresenterProtocol {
    func setup() {
        updateView()
    }

    func performAction() {}
}
