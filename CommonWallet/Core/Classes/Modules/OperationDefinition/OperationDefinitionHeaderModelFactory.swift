/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol OperationDefinitionHeaderModelFactoryProtocol {
    func createAssetTitle(assetId: String,
                          receiverId: String?,
                          locale: Locale) -> MultilineTitleIconViewModelProtocol?
    func createAmountTitle(assetId: String,
                           receiverId: String?,
                           locale: Locale) -> MultilineTitleIconViewModelProtocol?
    func createReceiverTitle(assetId: String,
                             receiverId: String?,
                             locale: Locale) -> MultilineTitleIconViewModelProtocol?
    func createFeeTitleForDescription(assetId: String,
                                      receiverId: String?,
                                      feeDescription: Fee,
                                      locale: Locale) -> MultilineTitleIconViewModelProtocol?
    func createDescriptionTitle(assetId: String,
                                receiverId: String?,
                                locale: Locale) -> MultilineTitleIconViewModelProtocol?
}

struct TransferDefinitionHeaderModelFactory: OperationDefinitionHeaderModelFactoryProtocol {
    func createAssetTitle(assetId: String,
                          receiverId: String?,
                          locale: Locale) -> MultilineTitleIconViewModelProtocol? {
        nil
    }

    func createAmountTitle(assetId: String,
                           receiverId: String?,
                           locale: Locale) -> MultilineTitleIconViewModelProtocol? {
        MultilineTitleIconViewModel(text: L10n.Amount.title)
    }

    func createReceiverTitle(assetId: String,
                             receiverId: String?,
                             locale: Locale) -> MultilineTitleIconViewModelProtocol? {
        nil
    }

    func createFeeTitleForDescription(assetId: String,
                                      receiverId: String?,
                                      feeDescription: Fee,
                                      locale: Locale) -> MultilineTitleIconViewModelProtocol? {
        nil
    }

    func createDescriptionTitle(assetId: String,
                                receiverId: String?,
                                locale: Locale) -> MultilineTitleIconViewModelProtocol? {
        MultilineTitleIconViewModel(text: L10n.Common.descriptionOptional)
    }
}

struct WithdrawDefinitionHeaderModelFactory: OperationDefinitionHeaderModelFactoryProtocol {
    let option: WalletWithdrawOption

    func createAssetTitle(assetId: String,
                          receiverId: String?,
                          locale: Locale) -> MultilineTitleIconViewModelProtocol? {
        nil
    }

    func createAmountTitle(assetId: String,
                           receiverId: String?,
                           locale: Locale) -> MultilineTitleIconViewModelProtocol? {
        MultilineTitleIconViewModel(text: L10n.Amount.title)
    }

    func createReceiverTitle(assetId: String,
                             receiverId: String?,
                             locale: Locale) -> MultilineTitleIconViewModelProtocol? {
        nil
    }

    func createFeeTitleForDescription(assetId: String,
                                      receiverId: String?,
                                      feeDescription: Fee,
                                      locale: Locale) -> MultilineTitleIconViewModelProtocol? {
        nil
    }

    func createDescriptionTitle(assetId: String,
                                receiverId: String?,
                                locale: Locale) -> MultilineTitleIconViewModelProtocol? {
        MultilineTitleIconViewModel(text: option.details)
    }
}
