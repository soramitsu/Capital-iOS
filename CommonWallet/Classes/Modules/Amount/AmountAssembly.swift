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

            let networkOperationFactory = WalletServiceOperationFactory(accountSettings: resolver.account)

            let dataProviderFactory = DataProviderFactory(networkResolver: resolver.networkResolver,
                                                          accountSettings: resolver.account,
                                                          cacheFacade: CoreDataCacheFacade.shared,
                                                          networkOperationFactory: networkOperationFactory)

            guard let balanceDataProvider = try? dataProviderFactory.createBalanceDataProvider() else {
                return nil
            }

            let assetSelectionFactory = AssetSelectionFactory(amountFormatter: resolver.amountFormatter)
            let accessoryViewModelFactory = ContactAccessoryViewModelFactory(style: resolver.style.nameIconStyle,
                                                                             radius: AccessoryView.iconRadius)

            let presenter = try  AmountPresenter(view: view,
                                                 coordinator: coordinator,
                                                 balanceDataProvider: balanceDataProvider,
                                                 account: resolver.account,
                                                 payload: payload,
                                                 assetSelectionFactory: assetSelectionFactory,
                                                 accessoryFactory: accessoryViewModelFactory,
                                                 amountLimit: resolver.transferAmountLimit,
                                                 inputValidatorFactory: resolver.inputValidatorFactory)
            view.presenter = presenter

            return view
        } catch {
            resolver.logger?.error("Did receive unexpected error \(error)")
            return nil
        }
    }
    
}
