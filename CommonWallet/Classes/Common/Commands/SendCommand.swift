import Foundation

final class SendCommand {
    let resolver: ResolverProtocol

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }
}

extension SendCommand: WalletCommandProtocol {
    func execute() throws {
        guard let contactsView = ContactsAssembly.assembleView(with: resolver) else {
            return
        }

        resolver.navigation?.present(contactsView.controller, inNavigationController: true)
    }
}
