/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

final class WithdrawResultAssembly: WithdrawResultAssemblyProtocol {
    static func assembleView(for resolver: ResolverProtocol,
                             info: WithdrawInfo,
                             asset: WalletAsset,
                             option: WalletWithdrawOption) -> WalletFormViewProtocol? {
        let view = WalletFormViewController(nibName: "WalletFormViewController", bundle: Bundle(for: self))
        view.accessoryViewFactory = AccessoryViewFactory.self
        view.style = resolver.style
        view.title = "All Done"
        
        let coordinator = WithdrawResultCoordinator(resolver: resolver)

        let presenter = WithdrawResultPresenter(view: view,
                                                coordinator: coordinator,
                                                withdrawInfo: info,
                                                asset: asset,
                                                withdrawOption: option,
                                                style: resolver.style,
                                                amountFormatter: resolver.amountFormatter,
                                                dateFormatter: resolver.statusDateFormatter)
        view.presenter = presenter

        return view
    }
}
