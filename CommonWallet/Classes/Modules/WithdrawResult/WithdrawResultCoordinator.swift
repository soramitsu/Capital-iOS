import Foundation

final class WithdrawResultCoordinator: WithdrawResultCoordinatorProtocol {
    let resolver: ResolverProtocol

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }

    func dismiss() {
        resolver.navigation?.dismiss()
    }
}
