/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


final class WithdrawConfirmationAssembly: WithdrawConfirmationAssemblyProtocol {
    static func assembleView(for resolver: ResolverProtocol,
                             info: WithdrawInfo,
                             asset: WalletAsset,
                             option: WalletWithdrawOption) -> WalletFormViewProtocol? {
        let view = WalletFormViewController(nibName: "WalletFormViewController", bundle: Bundle(for: self))
        view.loadingViewFactory = WalletLoadingOverlayFactory(style: resolver.style.loadingOverlayStyle)
        view.accessoryViewFactory = AccessoryViewFactory.self
        view.style = resolver.style
        view.title = "Confirmation"

        let coordinator = WithdrawConfirmationCoordinator(resolver: resolver)

        let walletService = WalletService(operationFactory: resolver.networkOperationFactory)

        let presenter = WithdrawConfirmationPresenter(view: view,
                                                      coordinator: coordinator,
                                                      walletService: walletService,
                                                      withdrawInfo: info,
                                                      asset: asset,
                                                      withdrawOption: option,
                                                      style: resolver.style,
                                                      amountFormatter: resolver.amountFormatter,
                                                      eventCenter: resolver.eventCenter)
        view.presenter = presenter

        return view
    }
}
