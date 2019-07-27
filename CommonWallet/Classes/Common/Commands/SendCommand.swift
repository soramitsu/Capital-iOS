import Foundation

final class SendCommand {
    let resolver: ResolverProtocol

    var presentationStyle: WalletPresentationStyle = .modal(inNavigation: true)

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }
}

extension SendCommand: WalletPresentationCommandProtocol {
    func execute() throws {
        guard
            let contactsView = ContactsAssembly.assembleView(with: resolver),
            let navigation = resolver.navigation else {
            return
        }

        present(view: contactsView, in: navigation)
    }
}
