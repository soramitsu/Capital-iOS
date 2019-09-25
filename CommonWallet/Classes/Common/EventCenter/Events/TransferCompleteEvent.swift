import Foundation

struct TransferCompleteEvent {
    let payload: TransferPayload
}

extension TransferCompleteEvent: WalletEventProtocol {
    func accept(visitor: WalletEventVisitorProtocol) {
        visitor.processTransferComplete(event: self)
    }
}
