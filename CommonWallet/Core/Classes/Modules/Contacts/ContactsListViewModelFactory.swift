/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol ContactsListViewModelFactoryProtocol {
    func createContactViewModelListFromItems(_ items: [SearchData],
                                             accountId: String,
                                             assetId: String,
                                             locale: Locale,
                                             delegate: ContactViewModelDelegate?)
        -> [ContactSectionViewModelProtocol]

    func createSearchViewModelListFromItems(_ items: [SearchData],
                                            accountId: String,
                                            assetId: String,
                                            locale: Locale,
                                            delegate: ContactViewModelDelegate?)
        -> [WalletViewModelProtocol]

    func createBarActionForAccountId(_ accountId: String, assetId: String)
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
                                             accountId: String,
                                             assetId: String,
                                             locale: Locale,
                                             delegate: ContactViewModelDelegate?)
        -> [ContactSectionViewModelProtocol] {

        var sections: [ContactSectionViewModelProtocol] = []

        let actions = actionViewModelFactory
            .createOptionListForAccountId(accountId, assetId: assetId, locale: locale)

        if !actions.isEmpty {
            let actionsSection = ContactSectionViewModel(title: nil, items: actions)
            sections.append(actionsSection)
        }

        let contacts = items.map {
            itemViewModelFactory.createContactViewModelFromContact($0,
                                                                   accountId: accountId,
                                                                   assetId: assetId,
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
                                            accountId: String,
                                            assetId: String,
                                            locale: Locale,
                                            delegate: ContactViewModelDelegate?)
        -> [WalletViewModelProtocol] {
        return items.map {
            itemViewModelFactory.createContactViewModelFromContact($0,
                                                                   accountId: accountId,
                                                                   assetId: assetId,
                                                                   delegate: delegate)
        }
    }

    func createBarActionForAccountId(_ accountId: String,
                                     assetId: String)
        -> WalletBarActionViewModelProtocol? {
        actionViewModelFactory.createBarActionForAccountId(accountId, assetId: assetId)
    }
}
