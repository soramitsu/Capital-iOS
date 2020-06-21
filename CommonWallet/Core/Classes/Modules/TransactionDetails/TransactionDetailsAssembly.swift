/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation

final class TransactionDetailsAssembly: TransactionDetailsAssemblyProtocol {
    static func assembleView(resolver: ResolverProtocol,
                             transactionDetails: AssetTransactionData) -> WalletNewFormViewProtocol? {

        guard resolver.transactionTypeList
                .first(where: { $0.backendName == transactionDetails.type }) != nil else {
                    resolver.logger?.error("Can't find transaction type for value \(transactionDetails.type)")
                    return nil
        }

        guard resolver.account.assets
                .first(where: { $0.identifier == transactionDetails.assetId }) != nil else {
                resolver.logger?.error("Can't find transaction asset for value \(transactionDetails.assetId)")
                return nil
        }

        let formDefinition = createFormDefinition(from: resolver)

        let view = WalletNewFormViewController(definition: formDefinition,
                                               style: resolver.style,
                                               accessoryViewFactory: AccessoryViewFactory.self)

        view.localizableTitle = LocalizableResource { _ in L10n.Transaction.details }

        let coordinator = TransactionDetailsCoordinator(resolver: resolver)

        let defaultViewModelFactory = createViewModelFactory(from: resolver)
        let viewModelFactory: WalletTransactionDetailsFactoryProtocol

        if let overriding = resolver.transactionDetailsConfiguration.viewModelFactory {
            viewModelFactory = WalletTransactionDetailsFactoryWrapper(overriding: overriding,
                                                                      defaultFactory: defaultViewModelFactory)
        } else {
            viewModelFactory = defaultViewModelFactory
        }

        let presenter = TransactionDetailsPresenter(view: view,
                                                    coordinator: coordinator,
                                                    transactionData: transactionDetails,
                                                    detailsViewModelFactory: viewModelFactory)
        view.presenter = presenter

        view.localizationManager = resolver.localizationManager
        presenter.localizationManager = resolver.localizationManager

        return view
    }

    private static func createFormDefinition(from resolver: ResolverProtocol) -> WalletFormDefiningProtocol {
        let formBinder = resolver.transactionDetailsConfiguration.customViewBinder ??
                WalletFormViewModelBinder(style: resolver.style)

        let formItemFactory = resolver.transactionDetailsConfiguration.customItemViewFactory ??
            WalletFormItemViewFactory()

        if let definitionFactory = resolver.transactionDetailsConfiguration.definitionFactory {
            return definitionFactory.createDefinitionWithBinder(formBinder,
                                                                itemFactory: formItemFactory)
        } else {
            return WalletFormDefinition(binder: formBinder,
                                        itemViewFactory: formItemFactory)
        }
    }

    private static func createViewModelFactory(from resolver: ResolverProtocol) -> WalletTransactionDetailsFactory {
        let sendBackTypes = resolver.transactionDetailsConfiguration.sendBackTransactionTypes
        let sendAgainTypes = resolver.transactionDetailsConfiguration.sendAgainTransactionTypes
        return WalletTransactionDetailsFactory(transactionTypes: resolver.transactionTypeList,
                                               assets: resolver.account.assets,
                                               feeDisplayFactory: resolver.feeDisplaySettingsFactory,
                                               generatingIconStyle: resolver.style.nameIconStyle,
                                               amountFormatterFactory: resolver.amountFormatterFactory,
                                               localizableDataFormatter: resolver.statusDateFormatter,
                                               sendBackTypes: sendBackTypes,
                                               sendAgainTypes: sendAgainTypes)
    }
}
