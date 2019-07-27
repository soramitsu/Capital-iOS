import Foundation

final class ReceiveCommand {
    let resolver: ResolverProtocol

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }
}

extension ReceiveCommand: WalletCommandProtocol {
    func execute() throws {
        guard let contactsView = ReceiveAmountAssembly.assembleView(resolver: resolver) else {
            return
        }

        resolver.navigation?.present(contactsView.controller, inNavigationController: true)
    }
}
