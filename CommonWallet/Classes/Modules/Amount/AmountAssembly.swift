/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

final class AmountAssembly: AmountAssemblyProtocol {
    
    static func assembleView(with resolver: ResolverProtocol,
                             payload: AmountPayload) -> AmountViewProtocol? {
        do {
            let view = AmountViewController(nibName: "AmountViewController", bundle: Bundle(for: self))

            view.style = resolver.style
            view.accessoryFactory = AccessoryViewFactory.self

            let coordinator = AmountCoordinator(resolver: resolver)

            let dataProviderFactory = DataProviderFactory(networkResolver: resolver.networkResolver,
                                                          accountSettings: resolver.account,
                                                          cacheFacade: CoreDataCacheFacade.shared,
                                                          networkOperationFactory: resolver.networkOperationFactory)

            let assetSelectionFactory = AssetSelectionFactory(amountFormatter: resolver.amountFormatter)
            let accessoryViewModelFactory = ContactAccessoryViewModelFactory(style: resolver.style.nameIconStyle,
                                                                             radius: AccessoryView.iconRadius)
            let inputValidatorFactory = resolver.inputValidatorFactory
            let transferViewModelFactory = AmountViewModelFactory(amountFormatter: resolver.amountFormatter,
                                                                  amountLimit: resolver.transferAmountLimit,
                                                                  descriptionValidatorFactory: inputValidatorFactory)

            let presenter = try  AmountPresenter(view: view,
                                                 coordinator: coordinator,
                                                 dataProviderFactory: dataProviderFactory,
                                                 account: resolver.account,
                                                 payload: payload,
                                                 transferViewModelFactory: transferViewModelFactory,
                                                 assetSelectionFactory: assetSelectionFactory,
                                                 accessoryFactory: accessoryViewModelFactory)
            view.presenter = presenter

            return view
        } catch {
            resolver.logger?.error("Did receive unexpected error \(error)")
            return nil
        }
    }
    
}
