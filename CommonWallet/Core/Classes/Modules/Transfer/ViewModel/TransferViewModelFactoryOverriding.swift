/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol TransferViewModelFactoryOverriding {
    func createFeeViewModel(_ inputState: TransferInputState,
                            fee: Fee,
                            payload: TransferPayload,
                            locale: Locale) throws -> FeeViewModelProtocol?

    func createAmountViewModel(_ inputState: TransferInputState,
                               payload: TransferPayload,
                               locale: Locale) throws -> AmountInputViewModelProtocol?

    func createDescriptionViewModel(_ inputState: TransferInputState,
                                    details: String?,
                                    payload: TransferPayload,
                                    locale: Locale) throws
    -> WalletOverridingResult<DescriptionInputViewModelProtocol?>?

    func createSelectedAssetViewModel(_ inputState: TransferInputState,
                                      selectedAssetState: SelectedAssetState,
                                      payload: TransferPayload,
                                      locale: Locale) throws -> AssetSelectionViewModelProtocol?

    func createAssetSelectionTitle(_ inputState: TransferInputState,
                                   payload: TransferPayload,
                                   locale: Locale) throws -> String?

    func createReceiverViewModel(_ inputState: TransferInputState,
                                 payload: TransferPayload,
                                 locale: Locale) throws
        -> MultilineTitleIconViewModelProtocol?

    func createAccessoryViewModel(_ inputState: TransferInputState,
                                  payload: TransferPayload?,
                                  locale: Locale) throws -> AccessoryViewModelProtocol?
}

public extension TransferViewModelFactoryOverriding {
    func createFeeViewModel(_ inputState: TransferInputState,
                            fee: Fee,
                            payload: TransferPayload,
                            locale: Locale) throws -> FeeViewModelProtocol? {
        return nil
    }

    func createAmountViewModel(_ inputState: TransferInputState,
                               payload: TransferPayload,
                               locale: Locale) throws -> AmountInputViewModelProtocol? {
        return nil
    }

    func createDescriptionViewModel(_ inputState: TransferInputState,
                                    details: String?,
                                    payload: TransferPayload,
                                    locale: Locale) throws
        -> WalletOverridingResult<DescriptionInputViewModelProtocol?>? {
        return nil
    }

    func createSelectedAssetViewModel(_ inputState: TransferInputState,
                                      selectedAssetState: SelectedAssetState,
                                      payload: TransferPayload,
                                      locale: Locale) throws -> AssetSelectionViewModelProtocol? {
        return nil
    }

    func createAssetSelectionTitle(_ inputState: TransferInputState,
                                   asset: WalletAsset,
                                   payload: TransferPayload,
                                   locale: Locale) throws -> String? {
        return nil
    }

    func createReceiverViewModel(_ inputState: TransferInputState,
                                 payload: TransferPayload,
                                 locale: Locale) throws
        -> MultilineTitleIconViewModelProtocol? {
        return nil
    }

    func createAccessoryViewModel(_ inputState: TransferInputState,
                                  payload: TransferPayload?,
                                  locale: Locale) throws -> AccessoryViewModelProtocol? {
        return nil
    }
}

struct TransferViewModelFactoryWrapper: TransferViewModelFactoryProtocol {
    let overriding: TransferViewModelFactoryOverriding
    let factory: TransferViewModelFactoryProtocol

    func createFeeViewModel(_ inputState: TransferInputState,
                            fee: Fee,
                            payload: TransferPayload,
                            locale: Locale) throws -> FeeViewModelProtocol {
        try overriding.createFeeViewModel(inputState, fee: fee, payload: payload, locale: locale) ??
        (try factory.createFeeViewModel(inputState, fee: fee, payload: payload, locale: locale))
    }

    func createAmountViewModel(_ inputState: TransferInputState,
                               payload: TransferPayload,
                               locale: Locale) throws -> AmountInputViewModelProtocol {
        try overriding.createAmountViewModel(inputState, payload: payload, locale: locale) ??
        (try factory.createAmountViewModel(inputState, payload: payload, locale: locale))
    }

    func createDescriptionViewModel(_ inputState: TransferInputState,
                                    details: String?,
                                    payload: TransferPayload,
                                    locale: Locale) throws
        -> DescriptionInputViewModelProtocol? {
        if let result = try overriding.createDescriptionViewModel(inputState,
                                                                  details: details,
                                                                  payload: payload,
                                                                  locale: locale) {
            return result.item
        }

        return try factory.createDescriptionViewModel(inputState,
                                                      details: details,
                                                      payload: payload,
                                                      locale: locale)
    }

    func createSelectedAssetViewModel(_ inputState: TransferInputState,
                                      selectedAssetState: SelectedAssetState,
                                      payload: TransferPayload,
                                      locale: Locale) throws -> AssetSelectionViewModelProtocol {
        try overriding.createSelectedAssetViewModel(inputState,
                                                    selectedAssetState: selectedAssetState,
                                                    payload: payload,
                                                    locale: locale) ??
        (try factory.createSelectedAssetViewModel(inputState,
                                                  selectedAssetState: selectedAssetState,
                                                  payload: payload,
                                                  locale: locale))
    }

    func createAssetSelectionTitle(_ inputState: TransferInputState,
                                   asset: WalletAsset,
                                   payload: TransferPayload,
                                   locale: Locale) throws -> String {
        try overriding.createAssetSelectionTitle(inputState,
                                                 asset: asset,
                                                 payload: payload,
                                                 locale: locale) ??
        (try factory.createAssetSelectionTitle(inputState,
                                               asset: asset,
                                               payload: payload,
                                               locale: locale))
    }

    func createReceiverViewModel(_ inputState: TransferInputState,
                                 payload: TransferPayload,
                                 locale: Locale) throws
        -> MultilineTitleIconViewModelProtocol {
        try overriding.createReceiverViewModel(inputState, payload: payload, locale: locale) ??
        (factory.createReceiverViewModel(inputState, payload: payload, locale: locale))
    }

    func createAccessoryViewModel(_ inputState: TransferInputState,
                                  payload: TransferPayload?,
                                  locale: Locale) throws -> AccessoryViewModelProtocol {
        try overriding.createAccessoryViewModel(inputState, payload: payload, locale: locale) ??
        (try factory.createAccessoryViewModel(inputState, payload: payload, locale: locale))
    }
}
