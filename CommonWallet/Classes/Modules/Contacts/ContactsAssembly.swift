/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

final class ContactsAssembly: ContactsAssemblyProtocol {
    static func assembleView(with resolver: ResolverProtocol) -> ContactsViewProtocol? {
        guard let selectedAsset = resolver.account.assets.first else {
            return nil
        }

        let view = ContactsViewController(nibName: "ContactsViewController", bundle: Bundle(for: self))
        
        let config = resolver.contactsConfiguration
        view.configuration = config
        view.style = resolver.style
        
        let coordinator = ContactsCoordinator(resolver: resolver)

        let networkOperationFactory = WalletServiceOperationFactory(accountSettings: resolver.account)
        
        let dataProviderFactory = DataProviderFactory(networkResolver: resolver.networkResolver,
                                                      accountSettings: resolver.account,
                                                      cacheFacade: CoreDataCacheFacade.shared,
                                                      networkOperationFactory: networkOperationFactory)

        guard let contactsDataProvider = try? dataProviderFactory.createContactsDataProvider() else {
            return nil
        }
        
        let walletService = WalletService(networkResolver: resolver.networkResolver,
                                          operationFactory: networkOperationFactory)

        let viewModelFactory = ContactsViewModelFactory(configuration: config,
                                                        avatarRadius: ContactCell.avatarRadius,
                                                        commandFactory: resolver.commandFactory)

        let presenter = ContactsPresenter(view: view,
                                          coordinator: coordinator,
                                          dataProvider: contactsDataProvider,
                                          walletService: walletService,
                                          viewModelFactory: viewModelFactory,
                                          selectedAsset: selectedAsset,
                                          currentAccountId: resolver.account.accountId)
        view.presenter = presenter

        return view
    }
}
