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
                                                             commandFactory: resolver.commandFactory)

        let networkOperationFactory = WalletServiceOperationFactory(accountSettings: resolver.account)

        let dataProviderFactory = DataProviderFactory(networkResolver: resolver.networkResolver,
                                                     accountSettings: resolver.account,
                                                     cacheFacade: CoreDataCacheFacade.shared,
                                                     networkOperationFactory: networkOperationFactory)

        guard let balanceDataProvider = try? dataProviderFactory.createBalanceDataProvider() else {
            return nil
        }

        let presenter = AccountListPresenter(view: view,
                                             coordinator: coordinator,
                                             balanceDataProvider: balanceDataProvider,
                                             viewModelFactory: viewModelFactory)
        presenter.logger = resolver.logger

        view.presenter = presenter

        return view
    }

    static func assembleView(with resolver: ResolverProtocol, detailsAsset: WalletAsset) -> AccountListViewProtocol? {
        let view = AccountListViewController(nibName: "AccountListViewController", bundle: Bundle(for: self))

        let coordinator = AccountListCoordinator(resolver: resolver)

        let configuration = resolver.accountListConfiguration
        view.configuration = configuration

        let detailsContext = AccountListViewModelContext(
            assetViewModelFactory: configuration.viewModelContext.assetViewModelFactory,
            showMoreViewModelFactory: configuration.viewModelContext.showMoreViewModelFactory,
            actionsViewModelFactory: configuration.viewModelContext.actionsViewModelFactory,
            minimumVisibleAssets: configuration.viewModelContext.minimumVisibleAssets)

        let viewModelFactory = AccountModuleViewModelFactory(context: detailsContext,
                                                             assets: [detailsAsset],
                                                             commandFactory: resolver.commandFactory)

        let networkOperationFactory = WalletServiceOperationFactory(accountSettings: resolver.account)

        let dataProviderFactory = DataProviderFactory(networkResolver: resolver.networkResolver,
                                                      accountSettings: resolver.account,
                                                      cacheFacade: CoreDataCacheFacade.shared,
                                                      networkOperationFactory: networkOperationFactory)

        guard let balanceDataProvider = try? dataProviderFactory.createBalanceDataProvider() else {
            return nil
        }

        let presenter = AccountListPresenter(view: view,
                                             coordinator: coordinator,
                                             balanceDataProvider: balanceDataProvider,
                                             viewModelFactory: viewModelFactory)
        presenter.logger = resolver.logger

        view.presenter = presenter

        return view
    }
}
