import Foundation

struct WithdrawCompleteEvent {
    let withdrawInfo: WithdrawInfo
}

extension WithdrawCompleteEvent: WalletEventProtocol {
    func accept(visitor: WalletEventVisitorProtocol) {
        visitor.processWithdrawComplete(event: self)
    }
}
