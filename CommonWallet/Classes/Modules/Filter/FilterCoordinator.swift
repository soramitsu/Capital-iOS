import Foundation


final class FilterCoordinator: FilterCoordinatorProtocol {
    
    let resolver: ResolverProtocol
    
    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }
    
    func dismiss() {
        resolver.navigation.dismiss()
    }
    
}
