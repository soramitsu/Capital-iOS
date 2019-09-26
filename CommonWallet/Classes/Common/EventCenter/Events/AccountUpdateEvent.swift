import Foundation

struct AccountUpdateEvent: WalletEventProtocol {
    func accept(visitor: WalletEventVisitorProtocol) {
        visitor.processAccountUpdate(event: self)
    }
}
