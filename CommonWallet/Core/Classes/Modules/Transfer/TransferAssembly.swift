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
            guard let view = createView(resolver) else {
                return nil
            }

            let coordinator = TransferCoordinator(resolver: resolver)
            let presenter = try createPresenter(resolver,
                                                payload: payload,
                                                view: view,
                                                coordinator: coordinator)

            view.presenter = presenter

            return view
        } catch {
            resolver.logger?.error("Did receive unexpected error \(error)")
            return nil
        }
    }

    private static func createViewModelFactory(from resolver: ResolverProtocol) -> TransferViewModelFactoryProtocol {

        let generatingIconStyle = resolver.transferConfiguration.generatingIconStyle
        let inputValidatorFactory = resolver.inputValidatorFactory
        let amountFormatterFactory = resolver.amountFormatterFactory
        let feeDisplaySettingsFactory = resolver.feeDisplaySettingsFactory
        let transactionSettings = resolver.transferConfiguration.settings

        let viewModelFactory = TransferViewModelFactory(accountId: resolver.account.accountId,
                                                        assets: resolver.account.assets,
                                                        amountFormatterFactory: amountFormatterFactory,
                                                        descriptionValidatorFactory: inputValidatorFactory,
                                                        feeDisplaySettingsFactory: feeDisplaySettingsFactory,
                                                        transactionSettings: transactionSettings,
                                                        generatingIconStyle: generatingIconStyle)

        if let overriding = resolver.transferConfiguration.transferViewModelFactory {
            return TransferViewModelFactoryWrapper(overriding: overriding,
                                                   factory: viewModelFactory)
        } else {
            return viewModelFactory
        }
    }

    private static func createView(_ resolver: ResolverProtocol) -> TransferViewController? {
        let containingFactory: OperationDefinitionViewFactoryProtocol

        if let factoryOverriding = resolver.transferConfiguration.operationDefinitionFactory {
            let defaultFactory = OperationDefinitionViewFactory(style: resolver.transferConfiguration.style,
                                                                defaultStyle: resolver.style)
            containingFactory = OperationDefinitionViewFactoryWrapper(overriding: factoryOverriding,
                                                                      factory: defaultFactory)
        } else {
            containingFactory = OperationDefinitionViewFactory(style: resolver.transferConfiguration.style,
                                                               defaultStyle: resolver.style)
        }

        let view = TransferViewController(containingFactory: containingFactory, style: resolver.style)

        if let accessoryViewFactory = resolver.transferConfiguration.accessoryViewFactory {
            view.accessoryViewFactory = accessoryViewFactory
        }

        view.localizableTitle = resolver.transferConfiguration.localizableTitle ??
            LocalizableResource { _ in L10n.Amount.moduleTitle }

        view.separatorsDistribution = resolver.transferConfiguration.separatorsDistribution
        view.accessoryViewType = resolver.transferConfiguration.accessoryViewType

        view.localizationManager = resolver.localizationManager

        return view
    }

    private static func createPresenter(_ resolver: ResolverProtocol,
                                        payload: TransferPayload,
                                        view: TransferViewProtocol,
                                        coordinator: TransferCoordinatorProtocol) throws
        -> TransferPresenter {
        let dataProviderFactory = DataProviderFactory(accountSettings: resolver.account,
                                                      cacheFacade: CoreDataCacheFacade.shared,
                                                      networkOperationFactory: resolver.networkOperationFactory,
                                                      identifierFactory: resolver.singleValueIdentifierFactory)

        let viewModelFactory = createViewModelFactory(from: resolver)

        let headerFactory = resolver.transferConfiguration.headerFactory
        let receiverPosition = resolver.transferConfiguration.receiverPosition

        let resultValidator = resolver.transferConfiguration.resultValidator
        let changeHandler = resolver.transferConfiguration.changeHandler
        let errorHandler = resolver.transferConfiguration.errorHandler
        let feeEditing = resolver.transferConfiguration.feeEditing

        let eligibleAssets = resolver.account.assets.filter { $0.modes.contains(.transfer) }

        let presenter = try  TransferPresenter(view: view,
                                               coordinator: coordinator,
                                               assets: eligibleAssets,
                                               accountId: resolver.account.accountId,
                                               payload: payload,
                                               dataProviderFactory: dataProviderFactory,
                                               feeCalculationFactory: resolver.feeCalculationFactory,
                                               resultValidator: resultValidator,
                                               changeHandler: changeHandler,
                                               viewModelFactory: viewModelFactory,
                                               headerFactory: headerFactory,
                                               receiverPosition: receiverPosition,
                                               localizationManager: resolver.localizationManager,
                                               errorHandler: errorHandler,
                                               feeEditing: feeEditing)
        presenter.logger = resolver.logger

        return presenter
    }
}
