/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

final class AccountListAssembly: AccountListAssemblyProtocol {
    static func assembleView(with resolver: ResolverProtocol) -> AccountListViewProtocol? {
        let view = AccountListViewController(nibName: "AccountListViewController", bundle: Bundle(for: self))

        let coordinator = AccountListCoordinator(resolver: resolver)

        let configuration = resolver.accountListConfiguration

        view.configuration = configuration

        let viewModelFactory = AccountModuleViewModelFactory(context: configuration.viewModelContext,
                                                             assets: resolver.account.assets,
                                                             commandFactory: resolver.commandFactory,
                                                             commandDecoratorFactory: resolver.commandDecoratorFactory,
                                                             amountFormatterFactory: resolver.amountFormatterFactory)

        let dataProviderFactory = DataProviderFactory(accountSettings: resolver.account,
                                                     cacheFacade: CoreDataCacheFacade.shared,
                                                     networkOperationFactory: resolver.networkOperationFactory)

        guard let balanceDataProvider = try? dataProviderFactory.createBalanceDataProvider() else {
            return nil
        }

        let presenter = AccountListPresenter(view: view,
                                             coordinator: coordinator,
                                             balanceDataProvider: balanceDataProvider,
                                             viewModelFactory: viewModelFactory,
                                             eventCenter: resolver.eventCenter)

        presenter.logger = resolver.logger
        presenter.localizationManager = resolver.localizationManager

        view.presenter = presenter

        return view
    }

    static func assembleView(with resolver: ResolverProtocol, detailsAsset: WalletAsset) -> AccountListViewProtocol? {
        let view = AccountListViewController(nibName: "AccountListViewController", bundle: Bundle(for: self))

        let coordinator = AccountListCoordinator(resolver: resolver)

        let configuration = resolver.accountListConfiguration
        view.configuration = configuration

        let accountContext = configuration.viewModelContext
        let emptyViewModelFactoryContainer = AccountListViewModelFactoryContainer()
        let listViewModelFactory = accountContext.accountListViewModelFactory
        let detailsContext = AccountListViewModelContext(viewModelFactoryContainer: emptyViewModelFactoryContainer,
                                                         accountListViewModelFactory: listViewModelFactory,
                                                         assetCellStyleFactory: accountContext.assetCellStyleFactory,
                                                         actionsStyle: accountContext.actionsStyle,
                                                         showMoreCellStyle: accountContext.showMoreCellStyle,
                                                         minimumVisibleAssets: accountContext.minimumVisibleAssets)

        let viewModelFactory = AccountModuleViewModelFactory(context: detailsContext,
                                                             assets: [detailsAsset],
                                                             commandFactory: resolver.commandFactory,
                                                             commandDecoratorFactory: resolver.commandDecoratorFactory,
                                                             amountFormatterFactory: resolver.amountFormatterFactory)

        let dataProviderFactory = DataProviderFactory(accountSettings: resolver.account,
                                                      cacheFacade: CoreDataCacheFacade.shared,
                                                      networkOperationFactory: resolver.networkOperationFactory)

        guard let balanceDataProvider = try? dataProviderFactory.createBalanceDataProvider() else {
            return nil
        }

        let presenter = AccountListPresenter(view: view,
                                             coordinator: coordinator,
                                             balanceDataProvider: balanceDataProvider,
                                             viewModelFactory: viewModelFactory,
                                             eventCenter: resolver.eventCenter)
        presenter.logger = resolver.logger

        view.presenter = presenter

        return view
    }
}
