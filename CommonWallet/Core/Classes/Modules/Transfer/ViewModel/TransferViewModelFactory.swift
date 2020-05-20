/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation

protocol TransferViewModelFactoryProtocol {
    func createFeeViewModel(_ fee: Fee,
                            feeAsset: WalletAsset,
                            payload: TransferPayload,
                            locale: Locale) -> FeeViewModelProtocol

    func createAmountViewModel(for asset: WalletAsset,
                               amount: Decimal?,
                               payload: TransferPayload,
                               locale: Locale) -> AmountInputViewModelProtocol

    func createDescriptionViewModelForDetails(_ details: String?,
                                              payload: TransferPayload) throws
        -> DescriptionInputViewModelProtocol

    func createSelectedAssetViewModel(for asset: WalletAsset?,
                                      balanceData: BalanceData?,
                                      selectedAssetState: SelectedAssetState,
                                      payload: TransferPayload,
                                      locale: Locale) -> AssetSelectionViewModelProtocol

    func createAssetSelectionTitle(_ asset: WalletAsset,
                                   balanceData: BalanceData?,
                                   payload: TransferPayload,
                                   locale: Locale) -> String

    func createReceiverViewModel(_ payload: TransferPayload, locale: Locale)
        -> MultilineTitleIconViewModelProtocol

    func createAccessoryViewModel(_ payload: TransferPayload?, locale: Locale) -> AccessoryViewModelProtocol
}

enum TransferViewModelFactoryError: Error {
    case missingValidator
}

struct TransferViewModelFactory {
    let account: WalletAccountSettingsProtocol
    let amountFormatterFactory: NumberFormatterFactoryProtocol
    let descriptionValidatorFactory: WalletInputValidatorFactoryProtocol
    let feeDisplaySettingsFactory: FeeDisplaySettingsFactoryProtocol
    let transactionSettings: WalletTransactionSettingsProtocol
    let generatingIconStyle: WalletNameIconStyleProtocol

    init(account: WalletAccountSettingsProtocol,
         amountFormatterFactory: NumberFormatterFactoryProtocol,
         descriptionValidatorFactory: WalletInputValidatorFactoryProtocol,
         feeDisplaySettingsFactory: FeeDisplaySettingsFactoryProtocol,
         transactionSettings: WalletTransactionSettingsProtocol,
         generatingIconStyle: WalletNameIconStyleProtocol) {
        self.account = account
        self.amountFormatterFactory = amountFormatterFactory
        self.descriptionValidatorFactory = descriptionValidatorFactory
        self.feeDisplaySettingsFactory = feeDisplaySettingsFactory
        self.transactionSettings = transactionSettings
        self.generatingIconStyle = generatingIconStyle
    }
}

extension TransferViewModelFactory: TransferViewModelFactoryProtocol {
    func createFeeViewModel(_ fee: Fee,
                            feeAsset: WalletAsset,
                            payload: TransferPayload,
                            locale: Locale) -> FeeViewModelProtocol {

        let feeDisplaySettings = feeDisplaySettingsFactory
            .createFeeSettingsForId(fee.feeDescription.identifier)

        let amountFormatter = amountFormatterFactory.createDisplayFormatter(for: feeAsset)

        guard let amountString = amountFormatter.value(for: locale)
            .string(from: fee.value.decimalValue as NSNumber) else {
            return FeeViewModel(title: L10n.Amount.defaultFee,
                                details: "",
                                isLoading: true,
                                allowsEditing: fee.feeDescription.userCanDefine)
        }

        let details = "\(feeAsset.symbol)\(amountString)"

        let title = feeDisplaySettings.operationTitle.value(for: locale)

        return FeeViewModel(title: title,
                            details: details,
                            isLoading: false,
                            allowsEditing: fee.feeDescription.userCanDefine)
    }

    func createAmountViewModel(for asset: WalletAsset,
                               amount: Decimal?,
                               payload: TransferPayload,
                               locale: Locale) -> AmountInputViewModelProtocol {

        let inputFormatter = amountFormatterFactory.createInputFormatter(for: asset)

        let localizedFormatter = inputFormatter.value(for: locale)

        let limit = transactionSettings.limitForAssetId(asset.identifier,
                                                        senderId: account.accountId,
                                                        receiverId: payload.receiveInfo.accountId)

        return AmountInputViewModel(symbol: asset.symbol,
                                    amount: amount,
                                    limit: limit.maximum,
                                    formatter: localizedFormatter,
                                    precision: Int16(localizedFormatter.maximumFractionDigits))
    }

    func createDescriptionViewModelForDetails(_ details: String?,
                                              payload: TransferPayload) throws
        -> DescriptionInputViewModelProtocol {
        guard let validator = descriptionValidatorFactory.createTransferDescriptionValidator() else {
                throw TransferViewModelFactoryError.missingValidator
        }

        if let details = details {
            _ = validator.didReceiveReplacement(details, for: NSRange(location: 0, length: 0))
        }

        return DescriptionInputViewModel(validator: validator)
    }

    func createSelectedAssetViewModel(for asset: WalletAsset?,
                                      balanceData: BalanceData?,
                                      selectedAssetState: SelectedAssetState,
                                      payload: TransferPayload,
                                      locale: Locale) -> AssetSelectionViewModelProtocol {
        let title: String
        let subtitle: String
        let details: String

        if let asset = asset {

            if let platform = asset.platform?.value(for: locale) {
                title = platform
                subtitle = asset.name.value(for: locale)
            } else {
                title = asset.name.value(for: locale)
                subtitle = ""
            }

            let amountFormatter = amountFormatterFactory.createDisplayFormatter(for: asset)

            if let balanceData = balanceData,
                let formattedBalance = amountFormatter.value(for: locale)
                    .string(from: balanceData.balance.decimalValue as NSNumber) {
                details = "\(asset.symbol)\(formattedBalance)"
            } else {
                details = ""
            }
        } else {
            title = L10n.AssetSelection.noAsset
            subtitle = ""
            details = ""
        }

        return AssetSelectionViewModel(title: title,
                                       subtitle: subtitle,
                                       details: details,
                                       icon: nil,
                                       state: selectedAssetState)
    }

    func createAssetSelectionTitle(_ asset: WalletAsset,
                                   balanceData: BalanceData?,
                                   payload: TransferPayload,
                                   locale: Locale) -> String {
        let state = SelectedAssetState(isSelecting: false, canSelect: false)
        let viewModel = createSelectedAssetViewModel(for: asset,
                                                     balanceData: balanceData,
                                                     selectedAssetState: state,
                                                     payload: payload,
                                                     locale: locale)

        if !viewModel.details.isEmpty {
            return "\(viewModel.title) - \(viewModel.details)"
        } else {
            return viewModel.title
        }
    }

    func createAccessoryViewModel(_ payload: TransferPayload?, locale: Locale) -> AccessoryViewModelProtocol {
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

    func createReceiverViewModel(_ payload: TransferPayload,
                                 locale: Locale) -> MultilineTitleIconViewModelProtocol {
        let icon = UIImage.createAvatar(fullName: payload.receiverName, style: generatingIconStyle)

        return MultilineTitleIconViewModel(text: payload.receiverName, icon: icon)
    }
}

public protocol TransferViewModelFactoryOverriding {
    func createFeeViewModel(_ fee: Fee,
                            feeAsset: WalletAsset,
                            payload: TransferPayload,
                            locale: Locale) -> FeeViewModelProtocol?

    func createAmountViewModel(for asset: WalletAsset,
                               amount: Decimal?,
                               payload: TransferPayload,
                               locale: Locale) -> AmountInputViewModelProtocol?

    func createDescriptionViewModelForDetails(_ details: String?,
                                              payload: TransferPayload) throws
        -> DescriptionInputViewModelProtocol?

    func createSelectedAssetViewModel(for asset: WalletAsset?,
                                      balanceData: BalanceData?,
                                      selectedAssetState: SelectedAssetState,
                                      payload: TransferPayload,
                                      locale: Locale) -> AssetSelectionViewModelProtocol?

    func createAssetSelectionTitle(_ asset: WalletAsset,
                                   balanceData: BalanceData?,
                                   payload: TransferPayload,
                                   locale: Locale) -> String?

    func createReceiverViewModel(_ payload: TransferPayload,
                                 locale: Locale) -> MultilineTitleIconViewModelProtocol?

    func createAccessoryViewModel(_ payload: TransferPayload?,
                                  locale: Locale) -> AccessoryViewModelProtocol?
}

public extension TransferViewModelFactoryOverriding {
    func createFeeViewModel(_ fee: Fee,
                            feeAsset: WalletAsset,
                            payload: TransferPayload,
                            locale: Locale) -> FeeViewModelProtocol? {
        nil
    }

    func createAmountViewModel(for asset: WalletAsset,
                               amount: Decimal?,
                               payload: TransferPayload,
                               locale: Locale) -> AmountInputViewModelProtocol? {
        nil
    }

    func createDescriptionViewModelForDetails(_ details: String?,
                                              payload: TransferPayload) throws
        -> DescriptionInputViewModelProtocol? {
        nil
    }

    func createSelectedAssetViewModel(for asset: WalletAsset?,
                                      balanceData: BalanceData?,
                                      selectedAssetState: SelectedAssetState,
                                      payload: TransferPayload,
                                      locale: Locale) -> AssetSelectionViewModelProtocol? {
        nil
    }

    func createAssetSelectionTitle(_ asset: WalletAsset,
                                   balanceData: BalanceData?,
                                   payload: TransferPayload,
                                   locale: Locale) -> String? {
        nil
    }

    func createReceiverViewModel(_ payload: TransferPayload,
                                 locale: Locale) -> MultilineTitleIconViewModelProtocol? {
        nil
    }

    func createAccessoryViewModel(_ payload: TransferPayload?,
                                  locale: Locale) -> AccessoryViewModelProtocol? {
        nil
    }
}

struct TransferViewModelFactoryWrapper: TransferViewModelFactoryProtocol {
    let overriding: TransferViewModelFactoryOverriding
    let factory: TransferViewModelFactoryProtocol

    func createFeeViewModel(_ fee: Fee,
                            feeAsset: WalletAsset,
                            payload: TransferPayload,
                            locale: Locale) -> FeeViewModelProtocol {
        overriding.createFeeViewModel(fee, feeAsset: feeAsset, payload: payload, locale: locale) ??
        factory.createFeeViewModel(fee, feeAsset: feeAsset, payload: payload, locale: locale)
    }

    func createAmountViewModel(for asset: WalletAsset,
                               amount: Decimal?,
                               payload: TransferPayload,
                               locale: Locale) -> AmountInputViewModelProtocol {
        overriding.createAmountViewModel(for: asset,
                                         amount: amount,
                                         payload: payload,
                                         locale: locale) ??
        factory.createAmountViewModel(for: asset,
                                      amount: amount,
                                      payload: payload,
                                      locale: locale)
    }

        func createDescriptionViewModelForDetails(_ details: String?,
                                                  payload: TransferPayload) throws
            -> DescriptionInputViewModelProtocol {
        try overriding.createDescriptionViewModelForDetails(details, payload: payload) ??
        (try factory.createDescriptionViewModelForDetails(details, payload: payload))
    }

    func createSelectedAssetViewModel(for asset: WalletAsset?,
                                      balanceData: BalanceData?,
                                      selectedAssetState: SelectedAssetState,
                                      payload: TransferPayload,
                                      locale: Locale) -> AssetSelectionViewModelProtocol {
        overriding.createSelectedAssetViewModel(for: asset,
                                                balanceData: balanceData,
                                                selectedAssetState: selectedAssetState,
                                                payload: payload,
                                                locale: locale) ??
        factory.createSelectedAssetViewModel(for: asset,
                                             balanceData: balanceData,
                                             selectedAssetState: selectedAssetState,
                                             payload: payload,
                                             locale: locale)
    }

    func createAssetSelectionTitle(_ asset: WalletAsset,
                                   balanceData: BalanceData?,
                                   payload: TransferPayload,
                                   locale: Locale) -> String {
        overriding.createAssetSelectionTitle(asset,
                                             balanceData: balanceData,
                                             payload: payload,
                                             locale: locale) ??
        factory.createAssetSelectionTitle(asset,
                                          balanceData: balanceData,
                                          payload: payload,
                                          locale: locale)
    }

    func createReceiverViewModel(_ payload: TransferPayload, locale: Locale)
        -> MultilineTitleIconViewModelProtocol {
        overriding.createReceiverViewModel(payload, locale: locale) ??
        factory.createReceiverViewModel(payload, locale: locale)
    }

    func createAccessoryViewModel(_ payload: TransferPayload?,
                                  locale: Locale) -> AccessoryViewModelProtocol {
        overriding.createAccessoryViewModel(payload, locale: locale) ??
        factory.createAccessoryViewModel(payload, locale: locale)
    }
}
