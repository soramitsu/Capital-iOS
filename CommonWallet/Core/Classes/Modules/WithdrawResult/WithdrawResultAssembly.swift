/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation


final class WithdrawResultAssembly: WithdrawResultAssemblyProtocol {
    static func assembleView(for resolver: ResolverProtocol,
                             info: WithdrawInfo,
                             asset: WalletAsset,
                             option: WalletWithdrawOption) -> WalletFormViewProtocol? {
        let view = WalletFormViewController(nibName: "WalletFormViewController", bundle: Bundle(for: self))
        view.accessoryViewFactory = AccessoryViewFactory.self
        view.style = resolver.style

        view.localizableTitle = LocalizableResource { _ in L10n.Transaction.done }
        
        let coordinator = WithdrawResultCoordinator(resolver: resolver)

        let amountFormatter = resolver.amountFormatterFactory.createTokenFormatter(for: asset)

        // TODO: Move to multifee variant
        let feeId = info.fees.first?.feeDescription.identifier ?? ""
        let feeDisplaySettings = resolver.feeDisplaySettingsFactory.createFeeSettingsForId(feeId)

        let presenter = WithdrawResultPresenter(view: view,
                                                coordinator: coordinator,
                                                withdrawInfo: info,
                                                asset: asset,
                                                withdrawOption: option,
                                                style: resolver.style,
                                                amountFormatter: amountFormatter,
                                                dateFormatter: resolver.statusDateFormatter,
                                                feeDisplaySettings: feeDisplaySettings)
        view.presenter = presenter

        view.localizationManager = resolver.localizationManager
        presenter.localizationManager = resolver.localizationManager

        return view
    }
}
