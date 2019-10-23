import Foundation

public enum WalletHideActionType {
    case pop
    case dismiss
}

public protocol WalletHideCommandProtocol: WalletCommandProtocol {
    var actionType: WalletHideActionType { get set }
    var animated: Bool { get set }
}
