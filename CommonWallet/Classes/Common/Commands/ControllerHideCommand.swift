import Foundation


public enum WalletHideActionType {
    case pop
    case dismiss
}


final class ControllerHideCommand: WalletCommandProtocol {
    let resolver: ResolverProtocol
    let actionType: WalletHideActionType

    init(resolver: ResolverProtocol, actionType: WalletHideActionType) {
        self.resolver = resolver
        self.actionType = actionType
    }

    func execute() throws {
        guard let navigation = resolver.navigation else {
            return
        }

        switch actionType {
        case .pop:
            navigation.pop()
        case .dismiss:
            navigation.dismiss()
        }
    }
}
