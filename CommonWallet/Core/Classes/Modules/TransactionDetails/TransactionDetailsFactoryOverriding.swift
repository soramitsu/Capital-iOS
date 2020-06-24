/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol WalletTransactionDetailsFactoryOverriding {
    func createViewModelsFromTransaction(data: AssetTransactionData,
                                         locale: Locale) -> [WalletFormViewBindingProtocol]?

    func createAccessoryViewModelFromTransaction(data: AssetTransactionData,
                                                 locale: Locale) -> AccessoryViewModelProtocol?
}

extension WalletTransactionDetailsFactoryOverriding {
    func createViewModelsFromTransaction(data: AssetTransactionData,
                                         locale: Locale) -> [WalletFormViewBindingProtocol]? {
        nil
    }

    func createAccessoryViewModelFromTransaction(data: AssetTransactionData,
                                                 locale: Locale) -> AccessoryViewModelProtocol? {
        nil
    }

    func generateReceiverIconForName(_ name: String, style: WalletNameIconStyleProtocol) -> UIImage? {
        UIImage.createAvatar(fullName: name, style: style)
    }
}

struct WalletTransactionDetailsFactoryWrapper: WalletTransactionDetailsFactoryProtocol {
    let overriding: WalletTransactionDetailsFactoryOverriding
    let defaultFactory: WalletTransactionDetailsFactoryProtocol

    func createViewModelsFromTransaction(data: AssetTransactionData, locale: Locale)
        -> [WalletFormViewBindingProtocol] {
        if let result = overriding.createViewModelsFromTransaction(data: data,
                                                                   locale: locale) {
            return result
        } else {
            return defaultFactory.createViewModelsFromTransaction(data: data,
                                                                  locale: locale)
        }
    }

    func createAccessoryViewModelFromTransaction(data: AssetTransactionData,
                                                 locale: Locale) -> AccessoryViewModelProtocol? {
        if let result = overriding.createAccessoryViewModelFromTransaction(data: data,
                                                                           locale: locale) {
            return result
        } else {
            return defaultFactory.createAccessoryViewModelFromTransaction(data: data,
                                                                          locale: locale)
        }
    }
}