import Foundation


final class ReceiveAmountCoordinator: ReceiveAmountCoordinatorProtocol {
    let resolver: ResolverProtocol

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }

    func close() {
        resolver.navigation.dismiss()
    }
}
