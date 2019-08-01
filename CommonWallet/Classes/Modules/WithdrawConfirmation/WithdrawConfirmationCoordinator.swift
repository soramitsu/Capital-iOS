import Foundation

final class WithdrawConfirmationCoordinator: WithdrawConfirmationCoordinatorProtocol {
    let resolver: ResolverProtocol

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }

    func showResult(for withdrawInfo: WithdrawInfo) {
        
    }
}
