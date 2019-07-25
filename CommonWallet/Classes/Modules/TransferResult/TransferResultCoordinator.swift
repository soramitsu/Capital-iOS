import Foundation


final class TransferResultCoordinator: TransferResultCoordinatorProtocol {
    let resolver: ResolverProtocol

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }

    func dismiss() {
        resolver.navigation.dismiss()
    }
}
