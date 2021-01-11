/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation


final class AccountDetailsAssembly: AccountDetailsAssemblyProtocol {
    static func assembleView(with resolver: ResolverProtocol, asset: WalletAsset) -> AccountDetailsViewProtocol? {
        let view = AccountDetailsViewController()
        view.style = resolver.style
        view.shouldInsertShadow = resolver.historyConfiguration.viewStyle.shouldInsertFullscreenShadow

        guard
            let accountListView = AccountListAssembly.assembleView(with: resolver, detailsAsset: asset),
            let historyView = HistoryAssembly.assembleView(with: resolver, assets: [asset], type: .hidden) else {
                return nil
        }

        view.localizableTile = resolver.accountDetailsConfiguration.localizableTitle
        view.additionalInsets = resolver.accountDetailsConfiguration.additionalInsets

        view.content = accountListView
        view.draggable = historyView

        let coordinator = AccountDetailsCoordinator()

        let presenter = AccountDetailsPresenter(view: view, coordinator: coordinator)
        view.presenter = presenter

        view.localizationManager = resolver.localizationManager

        return view
    }
}
