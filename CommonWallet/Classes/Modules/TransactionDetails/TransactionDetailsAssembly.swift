/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation

final class TransactionDetailsAssembly: TransactionDetailsAssemblyProtocol {
    static func assembleView(resolver: ResolverProtocol,
                             transactionDetails: AssetTransactionData) -> WalletFormViewProtocol? {

        guard
            let transactionType = resolver.transactionTypeList
                .first(where: { $0.backendName == transactionDetails.type }) else {
                    resolver.logger?.error("Can't find transaction type for value \(transactionDetails.type)")
                    return nil
        }

        guard let asset = resolver.account.assets
            .first(where: { $0.identifier.identifier() == transactionDetails.assetId }) else {
                resolver.logger?.error("Can't find transaction asset for value \(transactionDetails.assetId)")
                return nil
        }

        let view = WalletFormViewController(nibName: "WalletFormViewController", bundle: Bundle(for: self))
        view.accessoryViewFactory = AccessoryViewFactory.self
        view.style = resolver.style

        view.localizableTitle = LocalizableResource { _ in L10n.Transaction.details }

        let coordinator = TransactionDetailsCoordinator(resolver: resolver)

        let accessoryViewModelFactory = ContactAccessoryViewModelFactory(style: resolver.style.nameIconStyle,
                                                                         radius: AccessoryView.iconRadius)

        let viewModelFactory = WalletTransactionDetailsFactory(resolver: resolver)


        let presenter = TransactionDetailsPresenter(view: view,
                                                    coordinator: coordinator,
                                                    configuration: resolver.transactionDetailsConfiguration,
                                                    detailsViewModelFactory: viewModelFactory,
                                                    accessoryViewModelFactory: accessoryViewModelFactory,
                                                    transactionData: transactionDetails,
                                                    transactionType: transactionType, asset: asset)
        view.presenter = presenter

        view.localizationManager = resolver.localizationManager
        presenter.localizationManager = resolver.localizationManager

        return view
    }
}
