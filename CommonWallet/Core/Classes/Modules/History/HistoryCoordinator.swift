/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

final class HistoryCoordinator: HistoryCoordinatorProtocol {
    let resolver: ResolverProtocol

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }
    
    weak var delegate: HistoryCoordinatorDelegate?

    func presentFilter(filter: WalletHistoryRequest?, assets: [WalletAsset]) {
        guard let view = FilterAssembly.assembleView(with: resolver,
                                                     assets: assets,
                                                     filtering: self,
                                                     filter: filter) else {
            return
        }
        
        resolver.navigation?.present(view.controller, inNavigationController: true)
    }
    
}


extension HistoryCoordinator: Filterable {
    
    func set(filter: WalletHistoryRequest) {
        delegate?.coordinator(self, didReceive: filter)
    }
    
}
