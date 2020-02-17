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

        guard let asset = resolver.account.assets
            .first(where: { $0.identifier.identifier() == transactionDetails.assetId }) else {
                resolver.logger?.error("Can't find transaction asset for value \(transactionDetails.assetId)")
                return nil
        }

        let view = WalletFormViewController(nibName: "WalletFormViewController", bundle: Bundle(for: self))
        view.accessoryViewFactory = AccessoryViewFactory.self
        view.style = resolver.style

        view.title = L10n.Transaction.details

        let localizationManager = resolver.localizationManager
        localizationManager?.addObserver(with: view) { [weak view] (_, _) in
            view?.title = L10n.Transaction.details
        }

        let coordinator = TransactionDetailsCoordinator(resolver: resolver)

        let accessoryViewModelFactory = ContactAccessoryViewModelFactory(style: resolver.style.nameIconStyle,
                                                                         radius: AccessoryView.iconRadius)

        let senderId = transactionType.isIncome ? transactionDetails.peerId : resolver.account.accountId.identifier()
        let receiverId = transactionType.isIncome ? resolver.account.accountId.identifier() : transactionDetails.peerId

        let feeDisplaySettings = resolver.feeDisplaySettingsFactory
            .createFeeSettings(asset: asset,
                               senderId: senderId,
                               receiverId: receiverId)

        let presenter = TransactionDetailsPresenter(view: view,
                                                    coordinator: coordinator,
                                                    configuration: resolver.transactionDetailsConfiguration,
                                                    resolver: resolver,
                                                    transactionData: transactionDetails,
                                                    transactionType: transactionType,
                                                    accessoryViewModelFactory: accessoryViewModelFactory,
                                                    feeDisplaySettings: feeDisplaySettings)
        view.presenter = presenter

        presenter.localizationManager = localizationManager

        return view
    }
}
