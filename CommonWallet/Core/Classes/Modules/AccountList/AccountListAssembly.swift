/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood

final class AccountListAssembly: AccountListAssemblyProtocol {
    static func assembleView(with resolver: ResolverProtocol) -> AccountListViewProtocol? {
        let view = AccountListViewController(nibName: "AccountListViewController", bundle: Bundle(for: self))

        let coordinator = AccountListCoordinator(resolver: resolver)

        let configuration = resolver.accountListConfiguration

        view.configuration = configuration

        let visibleAssets = resolver.account.assets.filter { $0.modes.contains(.view) }

        let viewModelFactory = AccountModuleViewModelFactory(context: configuration.viewModelContext,
                                                             assets: visibleAssets,
                                                             commandFactory: resolver.commandFactory,
                                                             commandDecoratorFactory: resolver.commandDecoratorFactory,
                                                             amountFormatterFactory: resolver.amountFormatterFactory)

        let dataProviderFactory = DataProviderFactory(accountSettings: resolver.account,
                                                     cacheFacade: CoreDataCacheFacade.shared,
                                                     networkOperationFactory: resolver.networkOperationFactory,
                                                     identifierFactory: resolver.singleValueIdentifierFactory)

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

    static func assembleView(with resolver: ResolverProtocol,
                             detailsAsset: WalletAsset) -> AccountListViewProtocol? {
        let coordinator = AccountListCoordinator(resolver: resolver)

        let listConfiguration = resolver.accountListConfiguration
        let detailsConfiguration = resolver.accountDetailsConfiguration

        let accountContext = listConfiguration.viewModelContext
        let emptyViewModelFactoryContainer = AccountListViewModelFactoryContainer()
        let listViewModelFactory = detailsConfiguration.listViewModelFactory ??
            accountContext.accountListViewModelFactory

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
                                                      networkOperationFactory: resolver.networkOperationFactory,
                                                      identifierFactory: resolver.singleValueIdentifierFactory)

        guard let balanceDataProvider = try? dataProviderFactory.createBalanceDataProvider() else {
            return nil
        }

        return createDetailsController(with: coordinator,
                                       resolver: resolver,
                                       viewModelFactory: viewModelFactory,
                                       balanceDataProvider: balanceDataProvider)
    }

    private static func createDetailsController(with coordinator: AccountListCoordinatorProtocol,
                                                resolver: ResolverProtocol,
                                                viewModelFactory: AccountModuleViewModelFactory,
                                                balanceDataProvider: SingleValueProvider<[BalanceData]>)
        -> AccountListViewProtocol? {
        let detailsConfiguration = resolver.accountDetailsConfiguration
            let listConfiguration = resolver.accountListConfiguration

        if let containingViewFactory = detailsConfiguration.containingViewFactory {
            let view = containingViewFactory.createView()
            let viewController = AccountDetailsContainingController(containingView: view)

            let presenter = AccountListPresenter(view: viewController,
                                                 coordinator: coordinator,
                                                 balanceDataProvider: balanceDataProvider,
                                                 viewModelFactory: viewModelFactory,
                                                 eventCenter: resolver.eventCenter)
            presenter.logger = resolver.logger
            presenter.localizationManager = resolver.localizationManager

            viewController.presenter = presenter

            return viewController
        } else {
            let view = AccountListViewController(nibName: "AccountListViewController",
                                                 bundle: Bundle(for: self))
            view.configuration = listConfiguration

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
    }
}
