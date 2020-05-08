/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation

final class TransferAssembly: TransferAssemblyProtocol {
    
    static func assembleView(with resolver: ResolverProtocol,
                             payload: AmountPayload) -> TransferViewProtocol? {
        do {
            let containingFactory = OperationDefinitionViewFactory(style: resolver.transferConfiguration.style)
            let view = TransferViewController(containingFactory: containingFactory, style: resolver.style)
            view.localizableTitle = LocalizableResource { _ in L10n.Amount.moduleTitle }
            view.separatorsDistribution = resolver.transferConfiguration.separatorsDistribution
            view.accessoryViewType = resolver.transferConfiguration.accessoryViewType

            let coordinator = TransferCoordinator(resolver: resolver)

            let dataProviderFactory = DataProviderFactory(accountSettings: resolver.account,
                                                          cacheFacade: CoreDataCacheFacade.shared,
                                                          networkOperationFactory: resolver.networkOperationFactory)

            let assetSelectionFactory = AssetSelectionFactory(amountFormatterFactory: resolver.amountFormatterFactory)
            let accessoryViewModelFactory = ContactAccessoryViewModelFactory(style: resolver.style.nameIconStyle,
                                                                             radius: AccessoryView.iconRadius)
            let inputValidatorFactory = resolver.inputValidatorFactory
            let amountFormatterFactory = resolver.amountFormatterFactory
            let feeDisplaySettingsFactory = resolver.feeDisplaySettingsFactory
            let transactionFactory = resolver.transactionSettingsFactory

            let transferViewModelFactory = AmountViewModelFactory(amountFormatterFactory: amountFormatterFactory,
                                                                  descriptionValidatorFactory: inputValidatorFactory,
                                                                  transactionSettingsFactory: transactionFactory,
                                                                  feeDisplaySettingsFactory: feeDisplaySettingsFactory)

            let titleFactory = resolver.transferConfiguration.titleFactory
            let receiverPosition = resolver.transferConfiguration.receiverPosition

            let presenter = try  TransferPresenter(view: view,
                                                   coordinator: coordinator,
                                                   payload: payload,
                                                   dataProviderFactory: dataProviderFactory,
                                                   feeCalculationFactory: resolver.feeCalculationFactory,
                                                   account: resolver.account,
                                                   transferViewModelFactory: transferViewModelFactory,
                                                   assetSelectionFactory: assetSelectionFactory,
                                                   accessoryFactory: accessoryViewModelFactory,
                                                   titleFactory: titleFactory,
                                                   receiverPosition: receiverPosition,
                                                   localizationManager: resolver.localizationManager)
            view.presenter = presenter

            view.localizationManager = resolver.localizationManager

            return view
        } catch {
            resolver.logger?.error("Did receive unexpected error \(error)")
            return nil
        }
    }
    
}
