/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation


final class TransferConfirmationAssembly: TransferConfirmationAssemblyProtocol {
    
    static func assembleView(with resolver: ResolverProtocol, payload: ConfirmationPayload)
        -> WalletNewFormViewProtocol? {

        let formBinder = WalletFormViewModelBinder(style: resolver.style)
        let formItemFactory = WalletFormItemViewFactory()
        let formDefinition = WalletFormDefinition(binder: formBinder, itemViewFactory: formItemFactory)
        let view = WalletNewFormViewController(definition: formDefinition,
                                               style: resolver.style,
                                               accessoryViewFactory: AccessoryViewFactory.self)
        view.loadingViewFactory = WalletLoadingOverlayFactory(style: resolver.style.loadingOverlayStyle)
        view.localizableTitle = LocalizableResource { _ in L10n.Confirmation.title }
        
        let coordinator = TransferConfirmationCoordinator(resolver: resolver)
        
        let walletService = WalletService(operationFactory: resolver.networkOperationFactory)

        let feeDisplayFactory = resolver.feeDisplaySettingsFactory
        let generatingIconStyle = resolver.style.nameIconStyle
        let formatterFactory = resolver.amountFormatterFactory
        let viewModelfactory = TransferConfirmationViewModelFactory(assets: resolver.account.assets,
                                                                    feeDisplayFactory: feeDisplayFactory,
                                                                    generatingIconStyle: generatingIconStyle,
                                                                    amountFormatterFactory: formatterFactory)

        let presenter = TransferConfirmationPresenter(view: view,
                                                      coordinator: coordinator,
                                                      service: walletService,
                                                      payload: payload,
                                                      eventCenter: resolver.eventCenter,
                                                      viewModelFactory: viewModelfactory)

        presenter.logger = resolver.logger

        view.presenter = presenter

        view.localizationManager = resolver.localizationManager
        presenter.localizationManager = resolver.localizationManager

        return view
    }
    
}
