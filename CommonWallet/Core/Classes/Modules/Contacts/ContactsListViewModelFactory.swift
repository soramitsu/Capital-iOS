/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public struct ContactModuleParameters {
    public let accountId: String
    public let assetId: String
}

public protocol ContactsListViewModelFactoryProtocol {
    func createContactViewModelListFromItems(_ items: [SearchData],
                                             parameters: ContactModuleParameters,
                                             locale: Locale,
                                             delegate: ContactViewModelDelegate?,
                                             commandFactory: WalletCommandFactoryProtocol)
        -> [ContactSectionViewModelProtocol]

    func createSearchViewModelListFromItems(_ items: [SearchData],
                                            parameters: ContactModuleParameters,
                                            locale: Locale,
                                            delegate: ContactViewModelDelegate?,
                                            commandFactory: WalletCommandFactoryProtocol)
        -> [WalletViewModelProtocol]

    func createBarActionForAccountId(_ parameters: ContactModuleParameters,
                                     commandFactory: WalletCommandFactoryProtocol)
        -> WalletBarActionViewModelProtocol?
}

final class ContactsListViewModelFactory {
    private let itemViewModelFactory: ContactsViewModelFactoryProtocol
    private let actionViewModelFactory: ContactsActionViewModelFactoryProtocol

    init(itemViewModelFactory: ContactsViewModelFactoryProtocol,
         actionViewModelFactory: ContactsActionViewModelFactoryProtocol) {
        self.itemViewModelFactory = itemViewModelFactory
        self.actionViewModelFactory = actionViewModelFactory
    }
}

extension ContactsListViewModelFactory: ContactsListViewModelFactoryProtocol {
    func createContactViewModelListFromItems(_ items: [SearchData],
                                             parameters: ContactModuleParameters,
                                             locale: Locale,
                                             delegate: ContactViewModelDelegate?,
                                             commandFactory: WalletCommandFactoryProtocol)
        -> [ContactSectionViewModelProtocol] {

        var sections: [ContactSectionViewModelProtocol] = []

        let actions = actionViewModelFactory
            .createOptionListForAccountId(parameters.accountId,
                                          assetId: parameters.assetId,
                                          locale: locale,
                                          commandFactory: commandFactory)

        if !actions.isEmpty {
            let actionsSection = ContactSectionViewModel(title: nil, items: actions)
            sections.append(actionsSection)
        }

        let contacts = items.map {
            itemViewModelFactory.createContactViewModelFromContact($0,
                                                                   accountId: parameters.accountId,
                                                                   assetId: parameters.assetId,
                                                                   delegate: delegate)
        }

        if !contacts.isEmpty {
            let contactsSection = ContactSectionViewModel(title: L10n.Contacts.title,
                                                          items: contacts)
            sections.append(contactsSection)
        }

        return sections
    }

    func createSearchViewModelListFromItems(_ items: [SearchData],
                                            parameters: ContactModuleParameters,
                                            locale: Locale,
                                            delegate: ContactViewModelDelegate?,
                                            commandFactory: WalletCommandFactoryProtocol)
        -> [WalletViewModelProtocol] {
        return items.map {
            itemViewModelFactory.createContactViewModelFromContact($0,
                                                                   accountId: parameters.accountId,
                                                                   assetId: parameters.assetId,
                                                                   delegate: delegate)
        }
    }

    func createBarActionForAccountId(_ parameters: ContactModuleParameters,
                                     commandFactory: WalletCommandFactoryProtocol)
        -> WalletBarActionViewModelProtocol? {
        actionViewModelFactory.createBarActionForAccountId(parameters.accountId,
                                                           assetId: parameters.assetId,
                                                           commandFactory: commandFactory)
    }
}
