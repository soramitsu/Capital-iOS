/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation

final class TransferAssembly: TransferAssemblyProtocol {
    
    static func assembleView(with resolver: ResolverProtocol,
                             payload: TransferPayload) -> TransferViewProtocol? {
        do {
            let containingFactory = OperationDefinitionViewFactory(style: resolver.transferConfiguration.style,
                                                                   defaultStyle: resolver.style)
            let view = TransferViewController(containingFactory: containingFactory, style: resolver.style)

            view.localizableTitle = resolver.transferConfiguration.localizableTitle ??
                LocalizableResource { _ in L10n.Amount.moduleTitle }

            view.separatorsDistribution = resolver.transferConfiguration.separatorsDistribution
            view.accessoryViewType = resolver.transferConfiguration.accessoryViewType

            let coordinator = TransferCoordinator(resolver: resolver)

            let dataProviderFactory = DataProviderFactory(accountSettings: resolver.account,
                                                          cacheFacade: CoreDataCacheFacade.shared,
                                                          networkOperationFactory: resolver.networkOperationFactory)

            let generatingIconStyle = resolver.transferConfiguration.generatingIconStyle
            let inputValidatorFactory = resolver.inputValidatorFactory
            let amountFormatterFactory = resolver.amountFormatterFactory
            let feeDisplaySettingsFactory = resolver.feeDisplaySettingsFactory
            let transactionSettings = resolver.transferConfiguration.settings

            let viewModelFactoryWrapper: TransferViewModelFactoryProtocol
            let viewModelFactory = TransferViewModelFactory(account: resolver.account,
                                                            amountFormatterFactory: amountFormatterFactory,
                                                            descriptionValidatorFactory: inputValidatorFactory,
                                                            feeDisplaySettingsFactory: feeDisplaySettingsFactory,
                                                            transactionSettings: transactionSettings,
                                                            generatingIconStyle: generatingIconStyle)

            if let overriding = resolver.transferConfiguration.transferViewModelFactory {
                viewModelFactoryWrapper = TransferViewModelFactoryWrapper(overriding: overriding,
                                                                          factory: viewModelFactory)
            } else {
                viewModelFactoryWrapper = viewModelFactory
            }

            let headerFactory = resolver.transferConfiguration.headerFactory
            let receiverPosition = resolver.transferConfiguration.receiverPosition

            let resultValidator = resolver.transferConfiguration.resultValidator
            let changeHandler = resolver.transferConfiguration.changeHandler
            let errorHandler = resolver.transferConfiguration.errorHandler
            let feeEditing = resolver.transferConfiguration.feeEditing

            let presenter = try  TransferPresenter(view: view,
                                                   coordinator: coordinator,
                                                   payload: payload,
                                                   dataProviderFactory: dataProviderFactory,
                                                   feeCalculationFactory: resolver.feeCalculationFactory,
                                                   account: resolver.account,
                                                   resultValidator: resultValidator,
                                                   changeHandler: changeHandler,
                                                   viewModelFactory: viewModelFactoryWrapper,
                                                   headerFactory: headerFactory,
                                                   receiverPosition: receiverPosition,
                                                   localizationManager: resolver.localizationManager,
                                                   errorHandler: errorHandler,
                                                   feeEditing: feeEditing)
            presenter.logger = resolver.logger

            view.presenter = presenter

            view.localizationManager = resolver.localizationManager

            return view
        } catch {
            resolver.logger?.error("Did receive unexpected error \(error)")
            return nil
        }
    }
    
}
