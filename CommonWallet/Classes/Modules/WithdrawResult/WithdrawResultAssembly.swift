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

        let amountFormatter = resolver.amountFormatterFactory.createDisplayFormatter(for: asset)

        let feeDisplaySettings = resolver.feeDisplaySettingsFactory
            .createFeeSettings(asset: asset,
                               senderId: resolver.account.accountId.identifier(),
                               receiverId: info.destinationAccountId.identifier())

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
