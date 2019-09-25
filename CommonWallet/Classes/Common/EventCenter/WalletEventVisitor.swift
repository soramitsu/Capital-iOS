import Foundation

protocol WalletEventVisitorProtocol: class {
    func processTransferComplete(event: TransferCompleteEvent)
    func processWithdrawComplete(event: WithdrawCompleteEvent)
    func processAccountUpdate(event: AccountUpdateEvent)
}

extension WalletEventVisitorProtocol {
    func processTransferComplete(event: TransferCompleteEvent) {}
    func processWithdrawComplete(event: WithdrawCompleteEvent) {}
    func processAccountUpdate(event: AccountUpdateEvent) {}
}
