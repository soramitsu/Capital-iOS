import Foundation

final class ReceiveCommand {
    let resolver: ResolverProtocol

    var presentationStyle: WalletPresentationStyle = .modal(inNavigation: true)

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }
}

extension ReceiveCommand: WalletPresentationCommandProtocol {
    func execute() throws {
        guard
            let contactsView = ReceiveAmountAssembly.assembleView(resolver: resolver),
            let navigation = resolver.navigation else {
            return
        }

        present(view: contactsView, in: navigation)
    }
}
