/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol ContactsActionFactoryWrapperProtocol {
    func createOptionListForAccountId(_ accountId: String, assetId: String)
        -> [SendOptionViewModelProtocol]?
    func createBarActionForAccountId(_ accountId: String, assetId: String)
        -> WalletBarActionViewModelProtocol?
}

final class ContactsActionFactoryWrapper: ContactsActionViewModelFactoryProtocol {
    let customFactory: ContactsActionFactoryWrapperProtocol
    let defaultFactory: ContactsActionViewModelFactoryProtocol

    init(customFactory: ContactsActionFactoryWrapperProtocol,
         defaultFactory: ContactsActionViewModelFactoryProtocol) {
        self.customFactory = customFactory
        self.defaultFactory = defaultFactory
    }

    func createOptionListForAccountId(_ accountId: String, assetId: String)
        -> [SendOptionViewModelProtocol] {
        if let options = customFactory.createOptionListForAccountId(accountId, assetId: assetId) {
            return options
        } else {
            return defaultFactory.createOptionListForAccountId(accountId, assetId: assetId)
        }
    }

    func createBarActionForAccountId(_ accountId: String, assetId: String)
        -> WalletBarActionViewModelProtocol? {
        if let options = customFactory.createBarActionForAccountId(accountId, assetId: assetId) {
            return options
        } else {
            return defaultFactory.createBarActionForAccountId(accountId, assetId: assetId)
        }
    }
}
