/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation


final class WithdrawConfirmationAssembly: WithdrawConfirmationAssemblyProtocol {
    static func assembleView(for resolver: ResolverProtocol,
                             info: WithdrawInfo,
                             asset: WalletAsset,
                             option: WalletWithdrawOption) -> WalletFormViewProtocol? {
        let view = WalletFormViewController(nibName: "WalletFormViewController", bundle: Bundle(for: self))
        view.loadingViewFactory = WalletLoadingOverlayFactory(style: resolver.style.loadingOverlayStyle)
        view.accessoryViewFactory = AccessoryViewFactory.self
        view.style = resolver.style

        view.localizableTitle = LocalizableResource { _ in L10n.Confirmation.title }

        let coordinator = WithdrawConfirmationCoordinator(resolver: resolver)

        let walletService = WalletService(operationFactory: resolver.networkOperationFactory)

        let amountFormatter = resolver.amountFormatterFactory.createTokenFormatter(for: asset)

        // TODO: Move to multifee variant
        let feeId = info.fees.first?.feeDescription.identifier ?? ""
        let feeDisplaySettings = resolver.feeDisplaySettingsFactory.createFeeSettingsForId(feeId)

        let presenter = WithdrawConfirmationPresenter(view: view,
                                                      coordinator: coordinator,
                                                      walletService: walletService,
                                                      withdrawInfo: info,
                                                      asset: asset,
                                                      withdrawOption: option,
                                                      style: resolver.style,
                                                      amountFormatter: amountFormatter,
                                                      eventCenter: resolver.eventCenter,
                                                      feeDisplaySettings: feeDisplaySettings)
        view.presenter = presenter

        view.localizationManager = resolver.localizationManager
        presenter.localizationManager = resolver.localizationManager

        return view
    }
}
