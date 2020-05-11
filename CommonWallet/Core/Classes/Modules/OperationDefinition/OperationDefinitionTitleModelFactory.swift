/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol OperationDefinitionTitleModelFactoryProtocol {
    func createAssetTitle(assetId: String,
                          receiverId: String?) -> MultilineTitleIconViewModelProtocol?
    func createAmountTitle(assetId: String,
                           receiverId: String?) -> MultilineTitleIconViewModelProtocol?
    func createReceiverTitle(assetId: String,
                             receiverId: String?) -> MultilineTitleIconViewModelProtocol?
    func createFeeTitleForDescription(assetId: String,
                                      receiverId: String?,
                                      feeDescription: FeeDescription) -> MultilineTitleIconViewModelProtocol?
    func createDescriptionTitle(assetId: String,
                                receiverId: String?) -> MultilineTitleIconViewModelProtocol?
}

struct TransferDefinitionTitleModelFactory: OperationDefinitionTitleModelFactoryProtocol {
    func createAssetTitle(assetId: String,
                          receiverId: String?) -> MultilineTitleIconViewModelProtocol? {
        return nil
    }

    func createAmountTitle(assetId: String,
                           receiverId: String?) -> MultilineTitleIconViewModelProtocol? {
        return MultilineTitleIconViewModel(text: L10n.Amount.title)
    }

    func createReceiverTitle(assetId: String,
                             receiverId: String?) -> MultilineTitleIconViewModelProtocol? {
        return nil
    }

    func createFeeTitleForDescription(assetId: String,
                                      receiverId: String?,
                                      feeDescription: FeeDescription) -> MultilineTitleIconViewModelProtocol? {
        return nil
    }

    func createDescriptionTitle(assetId: String,
                                receiverId: String?) -> MultilineTitleIconViewModelProtocol? {
        return MultilineTitleIconViewModel(text: L10n.Common.descriptionOptional)
    }
}

struct WithdrawDefinitionTitleModelFactory: OperationDefinitionTitleModelFactoryProtocol {
    let option: WalletWithdrawOption

    func createAssetTitle(assetId: String,
                          receiverId: String?) -> MultilineTitleIconViewModelProtocol? {
        return nil
    }

    func createAmountTitle(assetId: String,
                           receiverId: String?) -> MultilineTitleIconViewModelProtocol? {
        return MultilineTitleIconViewModel(text: L10n.Amount.title)
    }

    func createReceiverTitle(assetId: String,
                             receiverId: String?) -> MultilineTitleIconViewModelProtocol? {
        return nil
    }

    func createFeeTitleForDescription(assetId: String,
                                      receiverId: String?,
                                      feeDescription: FeeDescription) -> MultilineTitleIconViewModelProtocol? {
        return nil
    }

    func createDescriptionTitle(assetId: String,
                                receiverId: String?) -> MultilineTitleIconViewModelProtocol? {
        return MultilineTitleIconViewModel(text: option.details)
    }
}
