/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

final class HistoryFilterEditor: HistoryFilterEditing {
    let resolver: ResolverProtocol

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }

    func startEditing(filter: WalletHistoryRequest,
                      with assets: [WalletAsset],
                      commandFactory: WalletCommandFactoryProtocol,
                      notifying delegate: HistoryFilterEditingDelegate?) {
        guard let view = HistoryFilterAssembly.assembleView(with: resolver,
                                                            assets: assets,
                                                            delegate: delegate,
                                                            filter: filter) else {
            return
        }

        resolver.navigation?.present(view.controller, inNavigationController: true)
    }
}
