import Foundation

final class TransactionDetailsCommand: WalletPresentationCommandProtocol {
    let transaction: AssetTransactionData
    let resolver: ResolverProtocol

    var presentationStyle: WalletPresentationStyle = .modal(inNavigation: true)
    var animated: Bool = true
    var completionBlock: (() -> Void)?

    init(resolver: ResolverProtocol, transaction: AssetTransactionData) {
        self.resolver = resolver
        self.transaction = transaction
    }

    func execute() throws {
        guard
            let trasactionDetailsView = TransactionDetailsAssembly
                .assembleView(resolver: resolver, transactionDetails: transaction),
            let navigation = resolver.navigation else {
            return
        }

        present(view: trasactionDetailsView.controller,
                in: navigation,
                animated: animated,
                completion: completionBlock)
    }
}
