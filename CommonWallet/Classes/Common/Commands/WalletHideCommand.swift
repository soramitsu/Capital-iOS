import Foundation

public enum WalletHideActionType {
    case dismiss
    case pop
    case popToRoot
}

public protocol WalletHideCommandProtocol: WalletCommandProtocol {
    var actionType: WalletHideActionType { get set }
    var animated: Bool { get set }
}
