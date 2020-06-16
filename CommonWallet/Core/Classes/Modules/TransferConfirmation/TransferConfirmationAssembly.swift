/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation


final class TransferConfirmationAssembly: TransferConfirmationAssemblyProtocol {
    
    static func assembleView(with resolver: ResolverProtocol, payload: ConfirmationPayload)
        -> WalletNewFormViewProtocol? {

        let formDefinition: WalletFormDefiningProtocol = createFormDefinition(from: resolver)

        let view = WalletNewFormViewController(definition: formDefinition,
                                               style: resolver.style,
                                               accessoryViewFactory: AccessoryViewFactory.self)
        view.loadingViewFactory = WalletLoadingOverlayFactory(style: resolver.style.loadingOverlayStyle)
        view.localizableTitle = resolver.transferConfirmationConfiguration.localizableTitle ??
            LocalizableResource { _ in L10n.Confirmation.title }
        view.accessoryViewType = resolver.transferConfirmationConfiguration.accessoryViewType

        let transferCompletion = resolver.transferConfirmationConfiguration.completion
        let coordinator = TransferConfirmationCoordinator(resolver: resolver,
                                                          completion: transferCompletion)
        
        let walletService = WalletService(operationFactory: resolver.networkOperationFactory)

        let viewModelFactory = createViewModelFactory(from: resolver)

        let presenter = TransferConfirmationPresenter(view: view,
                                                      coordinator: coordinator,
                                                      service: walletService,
                                                      payload: payload,
                                                      eventCenter: resolver.eventCenter,
                                                      viewModelFactory: viewModelFactory)

        presenter.logger = resolver.logger

        view.presenter = presenter

        view.localizationManager = resolver.localizationManager
        presenter.localizationManager = resolver.localizationManager

        return view
    }

    private static func createFormDefinition(from resolver: ResolverProtocol) -> WalletFormDefiningProtocol {
        let formBinder = resolver.transferConfirmationConfiguration.customViewBinder ??
                WalletFormViewModelBinder(style: resolver.style)

        let formItemFactory = resolver.transferConfirmationConfiguration.customItemViewFactory ??
            WalletFormItemViewFactory()

        if let definitionFactory = resolver.transferConfirmationConfiguration.definitionFactory {
            return definitionFactory.createDefinitionWithBinder(formBinder,
                                                                itemFactory: formItemFactory)
        } else {
            return WalletFormDefinition(binder: formBinder,
                                        itemViewFactory: formItemFactory)
        }
    }

    private static func createViewModelFactory(from resolver: ResolverProtocol)
        -> TransferConfirmationViewModelFactoryProtocol {

        let feeDisplayFactory = resolver.feeDisplaySettingsFactory
        let generatingIconStyle = resolver.style.nameIconStyle
        let formatterFactory = resolver.amountFormatterFactory

        let factory = TransferConfirmationViewModelFactory(assets: resolver.account.assets,
                                                           feeDisplayFactory: feeDisplayFactory,
                                                           generatingIconStyle: generatingIconStyle,
                                                           amountFormatterFactory: formatterFactory)

        if let factoryOverriding = resolver.transferConfirmationConfiguration
            .viewModelFactoryOverriding {
            return TransferConfirmationModelFactoryWrapper(overriding: factoryOverriding,
                                                           factory: factory)
        } else {
            return TransferConfirmationViewModelFactory(assets: resolver.account.assets,
                                                        feeDisplayFactory: feeDisplayFactory,
                                                        generatingIconStyle: generatingIconStyle,
                                                        amountFormatterFactory: formatterFactory)
        }
    }
}