/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation

final class ContactsAssembly: ContactsAssemblyProtocol {
    static func assembleView(with resolver: ResolverProtocol,
                             selectedAsset: WalletAsset) -> ContactsViewProtocol? {

        let view = ContactsViewController(nibName: "ContactsViewController", bundle: Bundle(for: self))
        
        let config = resolver.contactsConfiguration
        view.configuration = config
        view.style = resolver.style
        
        let coordinator = ContactsCoordinator(resolver: resolver)
        
        let dataProviderFactory = DataProviderFactory(accountSettings: resolver.account,
                                                      cacheFacade: CoreDataCacheFacade.shared,
                                                      networkOperationFactory: resolver.networkOperationFactory)

        guard let contactsDataProvider = try? dataProviderFactory.createContactsDataProvider() else {
            return nil
        }
        
        let walletService = WalletService(operationFactory: resolver.networkOperationFactory)

        let viewModelFactory = ContactsViewModelFactory(configuration: config,
                                                        avatarRadius: ContactCell.avatarRadius,
                                                        commandFactory: resolver.commandFactory)

        let presenter = ContactsPresenter(view: view,
                                          coordinator: coordinator,
                                          dataProvider: contactsDataProvider,
                                          walletService: walletService,
                                          viewModelFactory: viewModelFactory,
                                          selectedAsset: selectedAsset,
                                          currentAccountId: resolver.account.accountId,
                                          withdrawOptions: resolver.account.withdrawOptions)
        view.presenter = presenter

        view.localizationManager = resolver.localizationManager
        presenter.localizationManager = resolver.localizationManager

        return view
    }
}
