import Foundation

protocol WalletEventVisitorProtocol: class {
    func processTransferComplete(event: TransferCompleteEvent)
    func processWithdrawComplete(event: WithdrawCompleteEvent)
    func processTransactionsUpdate(event: TransactionsUpdateEvent)
}

extension WalletEventVisitorProtocol {
    func processTransferComplete(event: TransferCompleteEvent) {}
    func processWithdrawComplete(event: WithdrawCompleteEvent) {}
    func processTransactionsUpdate(event: TransactionsUpdateEvent) {}
}
