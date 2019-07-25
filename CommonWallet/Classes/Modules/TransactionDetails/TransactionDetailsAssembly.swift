/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


final class TransactionDetailsAssembly: TransactionDetailsAssemblyProtocol {
    static func assembleView(resolver: ResolverProtocol,
                             transactionDetails: AssetTransactionData) -> WalletFormViewProtocol? {
        let view = WalletFormViewController(nibName: "WalletFormViewController", bundle: Bundle(for: self))
        view.style = resolver.style
        view.title = "Transaction details"

        let coordinator = TransactionDetailsCoordinator()

        let presenter = TransactionDetailsPresenter(view: view, coordinator: coordinator,
                                                    resolver: resolver, transactionData: transactionDetails)
        view.presenter = presenter

        return view
    }
}
