/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol TransferConfirmationViewModelFactoryOverriding {
    func createViewModelsFromPayload(_ payload: ConfirmationPayload,
                                     locale: Locale) -> [WalletFormViewBindingProtocol]?

    func createAccessoryViewModelFromPayload(_ payload: ConfirmationPayload,
                                             locale: Locale) -> AccessoryViewModelProtocol?
}

public extension TransferConfirmationViewModelFactoryOverriding {
    func createViewModelsFromPayload(_ payload: ConfirmationPayload,
                                     locale: Locale) -> [WalletFormViewBindingProtocol]? {
        nil
    }

    func createAccessoryViewModelFromPayload(_ payload: ConfirmationPayload,
                                             locale: Locale) -> AccessoryViewModelProtocol? {
        nil
    }

    func generateReceiverIconForName(_ name: String, style: WalletNameIconStyleProtocol) -> UIImage? {
        UIImage.createAvatar(fullName: name, style: style)
    }
}

struct TransferConfirmationModelFactoryWrapper: TransferConfirmationViewModelFactoryProtocol {
    let overriding: TransferConfirmationViewModelFactoryOverriding
    let factory: TransferConfirmationViewModelFactoryProtocol

    func createViewModelsFromPayload(_ payload: ConfirmationPayload,
                                     locale: Locale) -> [WalletFormViewBindingProtocol] {
        overriding.createViewModelsFromPayload(payload, locale: locale) ??
        factory.createViewModelsFromPayload(payload, locale: locale)
    }

    func createAccessoryViewModelFromPayload(_ payload: ConfirmationPayload,
                                             locale: Locale) -> AccessoryViewModelProtocol {
        overriding.createAccessoryViewModelFromPayload(payload, locale: locale) ??
        factory.createAccessoryViewModelFromPayload(payload, locale: locale)
    }
}
