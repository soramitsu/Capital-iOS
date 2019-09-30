/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


final class TransactionDetailsAssembly: TransactionDetailsAssemblyProtocol {
    static func assembleView(resolver: ResolverProtocol,
                             transactionDetails: AssetTransactionData) -> WalletFormViewProtocol? {

        guard
            let transactionType = resolver.transactionTypeList
                .first(where: { $0.backendName == transactionDetails.type }) else {
                    resolver.logger?.error("Can't find transaction type for value \(transactionDetails.type)")
                    return nil
        }

        let view = WalletFormViewController(nibName: "WalletFormViewController", bundle: Bundle(for: self))
        view.accessoryViewFactory = AccessoryViewFactory.self
        view.style = resolver.style
        view.title = "Transaction details"

        let coordinator = TransactionDetailsCoordinator(resolver: resolver)

        let accessoryViewModelFactory = ContactAccessoryViewModelFactory(style: resolver.style.nameIconStyle,
                                                                         radius: AccessoryView.iconRadius)
        let presenter = TransactionDetailsPresenter(view: view,
                                                    coordinator: coordinator,
                                                    configuration: resolver.transactionDetailsConfiguration,
                                                    resolver: resolver,
                                                    transactionData: transactionDetails,
                                                    transactionType: transactionType,
                                                    accessoryViewModelFactory: accessoryViewModelFactory)
        view.presenter = presenter

        return view
    }
}
