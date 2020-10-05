/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation

public struct TransferInputState {
    public let selectedAsset: WalletAsset
    public let balance: BalanceData?
    public let amount: Decimal?
    public let metadata: TransferMetaData?

    public init(selectedAsset: WalletAsset,
                balance: BalanceData?,
                amount: Decimal?,
                metadata: TransferMetaData?) {
        self.selectedAsset = selectedAsset
        self.balance = balance
        self.amount = amount
        self.metadata = metadata
    }
}

protocol TransferViewModelFactoryProtocol {
    func createFeeViewModel(_ inputState: TransferInputState,
                            fee: Fee,
                            payload: TransferPayload,
                            locale: Locale) throws -> FeeViewModelProtocol

    func createAmountViewModel(_ inputState: TransferInputState,
                               payload: TransferPayload,
                               locale: Locale) throws -> AmountInputViewModelProtocol

    func createDescriptionViewModel(_ inputState: TransferInputState,
                                    details: String?,
                                    payload: TransferPayload,
                                    locale: Locale) throws
        -> DescriptionInputViewModelProtocol?

    func createSelectedAssetViewModel(_ inputState: TransferInputState,
                                      selectedAssetState: SelectedAssetState,
                                      payload: TransferPayload,
                                      locale: Locale) throws -> AssetSelectionViewModelProtocol

    func createAssetSelectionTitle(_ inputState: TransferInputState,
                                   asset: WalletAsset,
                                   payload: TransferPayload,
                                   locale: Locale) throws -> String

    func createReceiverViewModel(_ inputState: TransferInputState,
                                 payload: TransferPayload,
                                 locale: Locale) throws
        -> MultilineTitleIconViewModelProtocol

    func createAccessoryViewModel(_ inputState: TransferInputState,
                                  payload: TransferPayload?,
                                  locale: Locale) throws -> AccessoryViewModelProtocol
}

enum TransferViewModelFactoryError: Error {
    case missingValidator
    case missingAsset
}

struct TransferViewModelFactory {
    let accountId: String
    let assets: [WalletAsset]
    let amountFormatterFactory: NumberFormatterFactoryProtocol
    let descriptionValidatorFactory: WalletInputValidatorFactoryProtocol
    let feeDisplaySettingsFactory: FeeDisplaySettingsFactoryProtocol
    let transactionSettings: WalletTransactionSettingsProtocol
    let generatingIconStyle: WalletNameIconStyleProtocol

    init(accountId: String,
         assets: [WalletAsset],
         amountFormatterFactory: NumberFormatterFactoryProtocol,
         descriptionValidatorFactory: WalletInputValidatorFactoryProtocol,
         feeDisplaySettingsFactory: FeeDisplaySettingsFactoryProtocol,
         transactionSettings: WalletTransactionSettingsProtocol,
         generatingIconStyle: WalletNameIconStyleProtocol) {
        self.accountId = accountId
        self.assets = assets
        self.amountFormatterFactory = amountFormatterFactory
        self.descriptionValidatorFactory = descriptionValidatorFactory
        self.feeDisplaySettingsFactory = feeDisplaySettingsFactory
        self.transactionSettings = transactionSettings
        self.generatingIconStyle = generatingIconStyle
    }
}

extension TransferViewModelFactory: TransferViewModelFactoryProtocol {
    func createFeeViewModel(_ inputState: TransferInputState,
                            fee: Fee,
                            payload: TransferPayload,
                            locale: Locale) throws -> FeeViewModelProtocol {

        guard let feeAsset = assets.first(where: { $0.identifier == fee.feeDescription.assetId }) else {
            throw TransferViewModelFactoryError.missingAsset
        }

        let feeDisplaySettings = feeDisplaySettingsFactory
            .createFeeSettingsForId(fee.feeDescription.identifier)

        let amountFormatter = amountFormatterFactory.createTokenFormatter(for: feeAsset)

        guard let details = amountFormatter.value(for: locale)
            .string(from: fee.value.decimalValue) else {
            return FeeViewModel(title: L10n.Amount.defaultFee,
                                details: "",
                                isLoading: true,
                                allowsEditing: fee.feeDescription.userCanDefine)
        }

        let title = feeDisplaySettings.operationTitle.value(for: locale)

        return FeeViewModel(title: title,
                            details: details,
                            isLoading: false,
                            allowsEditing: fee.feeDescription.userCanDefine)
    }

    func createAmountViewModel(_ inputState: TransferInputState,
                               payload: TransferPayload,
                               locale: Locale) throws -> AmountInputViewModelProtocol {

        let inputFormatter = amountFormatterFactory.createInputFormatter(for: inputState.selectedAsset)

        let localizedFormatter = inputFormatter.value(for: locale)

        let limit = transactionSettings.limitForAssetId(inputState.selectedAsset.identifier,
                                                        senderId: accountId,
                                                        receiverId: payload.receiveInfo.accountId)

        return AmountInputViewModel(symbol: inputState.selectedAsset.symbol,
                                    amount: inputState.amount,
                                    limit: limit.maximum,
                                    formatter: localizedFormatter,
                                    precision: Int16(localizedFormatter.maximumFractionDigits))
    }

    func createDescriptionViewModel(_ inputState: TransferInputState,
                                    details: String?,
                                    payload: TransferPayload,
                                    locale: Locale) throws
    -> DescriptionInputViewModelProtocol? {
        guard let validator = descriptionValidatorFactory.createTransferDescriptionValidator() else {
                throw TransferViewModelFactoryError.missingValidator
        }

        if let details = details {
            _ = validator.didReceiveReplacement(details, for: NSRange(location: 0, length: 0))
        }

        return DescriptionInputViewModel(validator: validator)
    }

    func createSelectedAssetViewModel(_ inputState: TransferInputState,
                                      selectedAssetState: SelectedAssetState,
                                      payload: TransferPayload,
                                      locale: Locale) throws -> AssetSelectionViewModelProtocol {
        let title: String
        let subtitle: String
        let details: String

        let asset = inputState.selectedAsset

        if let platform = asset.platform?.value(for: locale) {
            title = platform
            subtitle = asset.name.value(for: locale)
        } else {
            title = asset.name.value(for: locale)
            subtitle = ""
        }

        let amountFormatter = amountFormatterFactory.createTokenFormatter(for: asset)

        if let balanceData = inputState.balance,
            let formattedBalance = amountFormatter.value(for: locale)
                .string(from: balanceData.balance.decimalValue) {
            details = formattedBalance
        } else {
            details = ""
        }

        return AssetSelectionViewModel(title: title,
                                       subtitle: subtitle,
                                       details: details,
                                       icon: nil,
                                       state: selectedAssetState)
    }

    func createAssetSelectionTitle(_ inputState: TransferInputState,
                                   asset: WalletAsset,
                                   payload: TransferPayload,
                                   locale: Locale) throws -> String {
        let state = SelectedAssetState(isSelecting: false, canSelect: false)
        let adoptedInputState = TransferInputState(selectedAsset: asset,
                                                   balance: nil,
                                                   amount: nil,
                                                   metadata: nil)
        let viewModel = try createSelectedAssetViewModel(adoptedInputState,
                                                         selectedAssetState: state,
                                                         payload: payload,
                                                         locale: locale)

        if !viewModel.details.isEmpty {
            return "\(viewModel.title) - \(viewModel.details)"
        } else {
            return viewModel.title
        }
    }

    func createAccessoryViewModel(_ inputState: TransferInputState,
                                  payload: TransferPayload?,
                                  locale: Locale) throws -> AccessoryViewModelProtocol {
        if let payload = payload {
            let icon = UIImage.createAvatar(fullName: payload.receiverName,
                                            style: generatingIconStyle)

            return AccessoryViewModel(title: payload.receiverName,
                                      action: L10n.Common.next,
                                      icon: icon)
        } else {
            return AccessoryViewModel(title: "", action: L10n.Common.next)
        }
    }

    func createReceiverViewModel(_ inputState: TransferInputState,
                                 payload: TransferPayload,
                                 locale: Locale) throws
        -> MultilineTitleIconViewModelProtocol {
        let icon = UIImage.createAvatar(fullName: payload.receiverName, style: generatingIconStyle)

        return MultilineTitleIconViewModel(text: payload.receiverName, icon: icon)
    }
}
