import Foundation


final class ConfirmationCoordinator: ConfirmationCoordinatorProtocol {
    let resolver: ResolverProtocol

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }

    func showResult(payload: TransferPayload) {
        guard let view = TransferResultAssembly.assembleView(resolver: resolver, transferPayload: payload) else {
            return
        }

        resolver.navigation.set(view.controller, animated: true)
    }
}
