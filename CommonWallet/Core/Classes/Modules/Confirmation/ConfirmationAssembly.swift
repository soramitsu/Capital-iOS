/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation


final class ConfirmationAssembly: ConfirmationAssemblyProtocol {
    
    static func assembleView(with resolver: ResolverProtocol, payload: TransferPayload)
        -> WalletFormViewProtocol? {
        let view = WalletFormViewController(nibName: "WalletFormViewController", bundle: Bundle(for: self))
        view.loadingViewFactory = WalletLoadingOverlayFactory(style: resolver.style.loadingOverlayStyle)
        view.accessoryViewFactory = AccessoryViewFactory.self
        view.style = resolver.style
        view.localizableTitle = LocalizableResource { _ in L10n.Confirmation.title }
        
        let coordinator = ConfirmationCoordinator(resolver: resolver)
        
        let walletService = WalletService(operationFactory: resolver.networkOperationFactory)

        let accessoryViewModelFactory = ContactAccessoryViewModelFactory(style: resolver.style.nameIconStyle)

        let feeId = payload.transferInfo.fees.first?.feeDescription.identifier ?? ""
        let feeDisplaySettings = resolver.feeDisplaySettingsFactory.createFeeSettingsForId(feeId)

        let presenter = ConfirmationPresenter(view: view,
                                              coordinator: coordinator,
                                              service: walletService,
                                              resolver: resolver,
                                              payload: payload,
                                              accessoryViewModelFactory: accessoryViewModelFactory,
                                              eventCenter: resolver.eventCenter,
                                              feeDisplaySettings: feeDisplaySettings)

        presenter.logger = resolver.logger

        view.presenter = presenter

        view.localizationManager = resolver.localizationManager
        presenter.localizationManager = resolver.localizationManager

        return view
    }
    
}
