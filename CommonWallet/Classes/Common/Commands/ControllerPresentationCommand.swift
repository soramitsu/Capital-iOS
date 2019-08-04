import Foundation

final class ControllerPresentationCommand: WalletPresentationCommandProtocol {
    let resolver: ResolverProtocol
    let controller: UIViewController

    var presentationStyle: WalletPresentationStyle = .modal(inNavigation: false)

    init(resolver: ResolverProtocol, controller: UIViewController) {
        self.resolver = resolver
        self.controller = controller
    }

    func execute() throws {
        guard let navigation = resolver.navigation else {
            return
        }

        present(view: controller, in: navigation)
    }
}
