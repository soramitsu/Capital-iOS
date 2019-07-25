import Foundation


final class FilterAssembly: FilterAssemblyProtocol {
    
    static func assembleView(with resolver: ResolverProtocol,
                             assets: [WalletAsset],
                             filtering: Filterable,
                             filter: WalletHistoryRequest?) -> FilterViewProtocol? {
        let view = FilterViewController(nibName: "FilterViewController", bundle: Bundle(for: self))
        let coordinator = FilterCoordinator(resolver: resolver)

        let presenter = FilterPresenter(view: view,
                                        coordinator: coordinator,
                                        assets: assets,
                                        transactionTypes: resolver.transactionTypeList,
                                        filteringInstance: filtering,
                                        filter: filter)
        
        view.presenter = presenter
        
        view.style = resolver.style

        return view
    }
    
}
