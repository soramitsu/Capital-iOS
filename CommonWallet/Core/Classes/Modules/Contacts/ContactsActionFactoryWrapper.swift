/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol ContactsActionFactoryWrapperProtocol {
    func createOptionListForAccountId(_ accountId: String,
                                      assetId: String,
                                      locale: Locale?,
                                      commandFactory: WalletCommandFactoryProtocol)
        -> [SendOptionViewModelProtocol]?
    func createBarActionForAccountId(_ accountId: String,
                                     assetId: String,
                                     commandFactory: WalletCommandFactoryProtocol)
        -> WalletBarActionViewModelProtocol?
}

public extension ContactsActionFactoryWrapperProtocol {
    func createOptionListForAccountId(_ accountId: String,
                                      assetId: String,
                                      locale: Locale?,
                                      commandFactory: WalletCommandFactoryProtocol)
        -> [SendOptionViewModelProtocol]? {
        nil
    }

    func createBarActionForAccountId(_ accountId: String,
                                     assetId: String,
                                     commandFactory: WalletCommandFactoryProtocol)
        -> WalletBarActionViewModelProtocol? {
        nil
    }
}

final class ContactsActionFactoryWrapper: ContactsActionViewModelFactoryProtocol {
    let customFactory: ContactsActionFactoryWrapperProtocol
    let defaultFactory: ContactsActionViewModelFactoryProtocol

    init(customFactory: ContactsActionFactoryWrapperProtocol,
         defaultFactory: ContactsActionViewModelFactoryProtocol) {
        self.customFactory = customFactory
        self.defaultFactory = defaultFactory
    }

    func createOptionListForAccountId(_ accountId: String,
                                      assetId: String,
                                      locale: Locale?,
                                      commandFactory: WalletCommandFactoryProtocol)
        -> [SendOptionViewModelProtocol] {
            if let options = customFactory
                .createOptionListForAccountId(accountId,
                                              assetId: assetId,
                                              locale: locale,
                                              commandFactory: commandFactory) {
            return options
        } else {
            return defaultFactory
                .createOptionListForAccountId(accountId,
                                              assetId: assetId,
                                              locale: locale,
                                              commandFactory: commandFactory)
        }
    }

    func createBarActionForAccountId(_ accountId: String,
                                     assetId: String,
                                     commandFactory: WalletCommandFactoryProtocol)
        -> WalletBarActionViewModelProtocol? {
        if let options = customFactory
            .createBarActionForAccountId(accountId,
                                         assetId: assetId,
                                         commandFactory: commandFactory) {
            return options
        } else {
            return defaultFactory
                .createBarActionForAccountId(accountId,
                                             assetId: assetId,
                                             commandFactory: commandFactory)
        }
    }
}
