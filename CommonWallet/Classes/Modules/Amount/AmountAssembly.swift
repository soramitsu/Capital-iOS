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
            let view = AmountViewController(nibName: "AmountViewController", bundle: Bundle(for: self))

            view.style = resolver.style
            view.accessoryFactory = AccessoryViewFactory.self

            let coordinator = AmountCoordinator(resolver: resolver)

            let dataProviderFactory = DataProviderFactory(accountSettings: resolver.account,
                                                          cacheFacade: CoreDataCacheFacade.shared,
                                                          networkOperationFactory: resolver.networkOperationFactory)

            let assetSelectionFactory = AssetSelectionFactory(amountFormatter: resolver.amountFormatter)
            let accessoryViewModelFactory = ContactAccessoryViewModelFactory(style: resolver.style.nameIconStyle,
                                                                             radius: AccessoryView.iconRadius)
            let inputValidatorFactory = resolver.inputValidatorFactory

            let inputFormatter = NumberFormatter.money(with: resolver.amountInputPrecision).localizableResource()
            let transferViewModelFactory = AmountViewModelFactory(inputFormatter: inputFormatter,
                                                                  amountFormatter: resolver.amountFormatter,
                                                                  amountLimit: resolver.transferAmountLimit,
                                                                  descriptionValidatorFactory: inputValidatorFactory,
                                                                  inputPrecision: resolver.amountInputPrecision)

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

            view.title = L10n.Amount.moduleTitle

            resolver.localizationManager?.addObserver(with: view) { [weak view] (_, _) in
                view?.title = L10n.Amount.moduleTitle
            }

            view.localizationManager = resolver.localizationManager

            return view
        } catch {
            resolver.logger?.error("Did receive unexpected error \(error)")
            return nil
        }
    }
    
}
