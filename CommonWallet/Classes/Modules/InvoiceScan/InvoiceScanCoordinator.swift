import Foundation


final class InvoiceScanCoordinator: InvoiceScanCoordinatorProtocol {
    let resolver: ResolverProtocol

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }

    func process(payload: AmountPayload) {
        guard let view = AmountAssembly.assembleView(with: resolver, payload: payload) else {
            return
        }

        resolver.navigation.push(view.controller)
    }
}
