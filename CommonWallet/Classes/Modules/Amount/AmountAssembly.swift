/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation

final class AmountAssembly: AmountAssemblyProtocol {
    
    static func assembleView(with resolver: ResolverProtocol,
                             payload: AmountPayload) -> AmountViewProtocol? {
        do {
            let containingFactory = ContainingViewFactory(style: resolver.style)
            let view = AmountViewController(containingFactory: containingFactory, style: resolver.style)

            let coordinator = AmountCoordinator(resolver: resolver)

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

            let presenter = try  AmountPresenter(view: view,
                                                 coordinator: coordinator,
                                                 payload: payload,
                                                 dataProviderFactory: dataProviderFactory,
                                                 feeCalculationFactory: resolver.feeCalculationFactory,
                                                 account: resolver.account,
                                                 transferViewModelFactory: transferViewModelFactory,
                                                 assetSelectionFactory: assetSelectionFactory,
                                                 accessoryFactory: accessoryViewModelFactory,
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
