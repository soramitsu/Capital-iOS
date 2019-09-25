import Foundation

struct TransactionsUpdateEvent {
    let transactions: [AssetTransactionData]
}

extension TransactionsUpdateEvent: WalletEventProtocol {
    func accept(visitor: WalletEventVisitorProtocol) {
        visitor.processTransactionsUpdate(event: self)
    }
}
