/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

final class DashboardAssembly: DashboardAssemblyProtocol {
    static func assembleView(with resolver: ResolverProtocol) -> DashboardViewProtocol? {
        let view = DashboardViewController()
        view.style = resolver.style
        view.shouldInsertShadow = resolver.historyConfiguration.viewStyle.shouldInsertFullscreenShadow

        let assets = resolver.account.assets

        guard
            let accountListView = AccountListAssembly.assembleView(with: resolver),
            let historyView = HistoryAssembly.assembleView(with: resolver, assets: assets, type: .bar)
        else {
            return nil
        }

        view.content = accountListView
        view.draggable = historyView
        
        let coordinator = DashboardCoordinator()

        let presenter = DashboardPresenter(view: view, coordinator: coordinator)
        view.presenter = presenter

        return view
    }
}
