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

        let accessoryViewFactory = resolver.transactionDetailsConfiguration.accessoryViewFactory
            ?? AccessoryViewFactory.self

        let view = WalletNewFormViewController(definition: formDefinition,
                                               style: resolver.style,
                                               accessoryViewFactory: accessoryViewFactory)

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
                                                    detailsViewModelFactory: viewModelFactory,
                                                    commandFactory: resolver.commandFactory)
        view.presenter = presenter

        view.localizationManager = resolver.localizationManager
        presenter.localizationManager = resolver.localizationManager

        return view
    }

    private static func createFormDefinition(from resolver: ResolverProtocol) -> WalletFormDefining {
        let binder: WalletFormViewModelBinderProtocol

        if let formBinder = resolver.transactionDetailsConfiguration.customViewBinder {
            let defaultBinder = WalletFormViewModelBinder(style: resolver.style)
            binder = WalletFormViewModelBinderWrapper(overriding: formBinder,
                                                      defaultBinder: defaultBinder)
        } else {
            binder = WalletFormViewModelBinder(style: resolver.style)
        }

        let itemFactory: WalletFormItemViewFactoryProtocol

        if let formItemFactory = resolver.transactionDetailsConfiguration.customItemViewFactory {
            itemFactory = WalletFormItemViewFactoryWrapper(overriding: formItemFactory,
                                                           defaultFactory: WalletFormItemViewFactory())
        } else {
            itemFactory = WalletFormItemViewFactory()
        }

        if let definitionFactory = resolver.transactionDetailsConfiguration.definitionFactory {
            return definitionFactory.createDefinitionWithBinder(binder,
                                                                itemFactory: itemFactory)
        } else {
            return WalletFormDefinition(binder: binder,
                                        itemViewFactory: itemFactory)
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
