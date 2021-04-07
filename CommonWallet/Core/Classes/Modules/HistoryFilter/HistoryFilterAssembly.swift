/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


final class HistoryFilterAssembly: HistoryFilterAssemblyProtocol {
    static func assembleView(with resolver: ResolverProtocol,
                             assets: [WalletAsset],
                             delegate: HistoryFilterEditingDelegate?,
                             filter: WalletHistoryRequest) -> HistoryFilterViewProtocol? {
        let view = HistoryFilterViewController(nibName: "HistoryFilterViewController",
                                               bundle: Bundle(for: self))

        let coordinator = HistoryFilterCoordinator(resolver: resolver)

        let typeFilters = WalletTransactionTypeFilter.createAllFilters(from: resolver.transactionTypeList)
        let presenter = HistoryFilterPresenter(view: view,
                                               coordinator: coordinator,
                                               assets: assets,
                                               typeFilters: typeFilters,
                                               filter: filter,
                                               delegate: delegate)
        
        view.presenter = presenter
        
        view.style = resolver.style

        presenter.localizationManager = resolver.localizationManager

        return view
    }
    
}
