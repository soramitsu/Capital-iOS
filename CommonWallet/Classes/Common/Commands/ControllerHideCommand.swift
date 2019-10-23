import Foundation


final class ControllerHideCommand: WalletHideCommandProtocol {
    let resolver: ResolverProtocol
    var actionType: WalletHideActionType
    var animated: Bool = true

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
            navigation.pop(animated: animated)
        case .dismiss:
            navigation.dismiss(animated: animated)
        }
    }
}
