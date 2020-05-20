/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation


final class TransferResultAssembly: TransferResultAssemblyProtocol {
    static func assembleView(resolver: ResolverProtocol, payload: ConfirmationPayload)
        -> WalletFormViewProtocol? {
        let view = WalletFormViewController(nibName: "WalletFormViewController", bundle: Bundle(for: self))
        view.accessoryViewFactory = AccessoryViewFactory.self
        view.style = resolver.style
        view.localizableTitle = LocalizableResource { _ in L10n.Transaction.done }

        let coordinator = TransferResultCoordinator(resolver: resolver)

        // TODO: Move to multifee variant
        let feeId = payload.transferInfo.fees.first?.feeDescription.identifier ?? ""
        let feeDisplaySettings = resolver.feeDisplaySettingsFactory.createFeeSettingsForId(feeId)

        let presenter = TransferResultPresenter(view: view,
                                                coordinator: coordinator,
                                                payload: payload,
                                                resolver: resolver,
                                                feeDisplaySettings: feeDisplaySettings)
        view.presenter = presenter

        view.localizationManager = resolver.localizationManager
        presenter.localizationManager = resolver.localizationManager

        return view
    }
}
