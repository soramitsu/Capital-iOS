/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


final class FilterAssembly: FilterAssemblyProtocol {
    
    static func assembleView(with resolver: ResolverProtocol,
                             assets: [WalletAsset],
                             filtering: Filterable,
                             filter: WalletHistoryRequest?) -> FilterViewProtocol? {
        let view = FilterViewController(nibName: "FilterViewController", bundle: Bundle(for: self))
        let coordinator = FilterCoordinator(resolver: resolver)

        let typeFilters = WalletTransactionTypeFilter.createAllFilters(from: resolver.transactionTypeList)
        let presenter = FilterPresenter(view: view,
                                        coordinator: coordinator,
                                        assets: assets,
                                        typeFilters: typeFilters,
                                        filteringInstance: filtering,
                                        filter: filter)
        
        view.presenter = presenter
        
        view.style = resolver.style

        presenter.localizationManager = resolver.localizationManager

        return view
    }
    
}
