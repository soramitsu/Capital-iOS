/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation

protocol TransferViewModelFactoryProtocol {
    func createFeeViewModel(_ fee: Fee,
                            feeAsset: WalletAsset,
                            locale: Locale) -> FeeViewModelProtocol

    func createAmountViewModel(for asset: WalletAsset,
                               sender: String?,
                               receiver: String?,
                               amount: Decimal?,
                               locale: Locale) -> AmountInputViewModelProtocol

    func createDescriptionViewModel(for details: String?) throws -> DescriptionInputViewModelProtocol

    func createSelectedAssetViewModel(for asset: WalletAsset?,
                                      balanceData: BalanceData?,
                                      isSelecting: Bool,
                                      canSelect: Bool,
                                      locale: Locale) -> AssetSelectionViewModelProtocol

    func createAssetSelectionTitle(_ asset: WalletAsset,
                                   balanceData: BalanceData?,
                                   locale: Locale) -> String
}

enum TransferViewModelFactoryError: Error {
    case missingValidator
}

final class TransferViewModelFactory {
    let amountFormatterFactory: NumberFormatterFactoryProtocol
    let descriptionValidatorFactory: WalletInputValidatorFactoryProtocol
    let feeDisplaySettingsFactory: FeeDisplaySettingsFactoryProtocol
    let transactionSettings: WalletTransactionSettingsProtocol

    init(amountFormatterFactory: NumberFormatterFactoryProtocol,
         descriptionValidatorFactory: WalletInputValidatorFactoryProtocol,
         feeDisplaySettingsFactory: FeeDisplaySettingsFactoryProtocol,
         transactionSettings: WalletTransactionSettingsProtocol) {
        self.amountFormatterFactory = amountFormatterFactory
        self.descriptionValidatorFactory = descriptionValidatorFactory
        self.feeDisplaySettingsFactory = feeDisplaySettingsFactory
        self.transactionSettings = transactionSettings
    }
}

extension TransferViewModelFactory: TransferViewModelFactoryProtocol {
    func createFeeViewModel(_ fee: Fee,
                            feeAsset: WalletAsset,
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
                               sender: String?,
                               receiver: String?,
                               amount: Decimal?,
                               locale: Locale) -> AmountInputViewModelProtocol {

        let inputFormatter = amountFormatterFactory.createInputFormatter(for: asset)

        let localizedFormatter = inputFormatter.value(for: locale)

        let limit = transactionSettings.limitForAssetId(asset.identifier,
                                                        senderId: sender,
                                                        receiverId: receiver)

        return AmountInputViewModel(symbol: asset.symbol,
                                    amount: amount,
                                    limit: limit.maximum,
                                    formatter: localizedFormatter,
                                    precision: Int16(localizedFormatter.maximumFractionDigits))
    }

    func createDescriptionViewModel(for details: String?) throws -> DescriptionInputViewModelProtocol {
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
                                      isSelecting: Bool,
                                      canSelect: Bool,
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
                                       isSelecting: isSelecting,
                                       canSelect: canSelect)
    }

    func createAssetSelectionTitle(_ asset: WalletAsset,
                                   balanceData: BalanceData?,
                                   locale: Locale) -> String {
        let viewModel = createSelectedAssetViewModel(for: asset,
                                                     balanceData: balanceData,
                                                     isSelecting: false,
                                                     canSelect: false,
                                                     locale: locale)

        if !viewModel.details.isEmpty {
            return "\(viewModel.title) - \(viewModel.details)"
        } else {
            return viewModel.title
        }
    }
}

public protocol TransferViewModelFactoryOverriding {
    func createFeeViewModel(_ fee: Fee,
                            feeAsset: WalletAsset,
                            locale: Locale) -> FeeViewModelProtocol?

    func createAmountViewModel(for asset: WalletAsset,
                               sender: String?,
                               receiver: String?,
                               amount: Decimal?,
                               locale: Locale) -> AmountInputViewModelProtocol?

    func createDescriptionViewModel(for details: String?) throws -> DescriptionInputViewModelProtocol?

    func createSelectedAssetViewModel(for asset: WalletAsset?,
                                      balanceData: BalanceData?,
                                      isSelecting: Bool,
                                      canSelect: Bool,
                                      locale: Locale) -> AssetSelectionViewModelProtocol?

    func createAssetSelectionTitle(_ asset: WalletAsset,
                                   balanceData: BalanceData?,
                                   locale: Locale) -> String?
}

public extension TransferViewModelFactoryOverriding {
    func createFeeViewModel(_ fee: Fee,
                            feeAsset: WalletAsset,
                            locale: Locale) -> FeeViewModelProtocol? {
        return nil
    }

    func createAmountViewModel(for asset: WalletAsset,
                               sender: String?,
                               receiver: String?,
                               amount: Decimal?,
                               locale: Locale) -> AmountInputViewModelProtocol? {
        return nil
    }

    func createDescriptionViewModel(for details: String?) throws -> DescriptionInputViewModelProtocol? {
        return nil
    }

    func createSelectedAssetViewModel(for asset: WalletAsset?,
                                      balanceData: BalanceData?,
                                      isSelecting: Bool,
                                      canSelect: Bool,
                                      locale: Locale) -> AssetSelectionViewModelProtocol? {
        return nil
    }

    func createAssetSelectionTitle(_ asset: WalletAsset,
                                   balanceData: BalanceData?,
                                   locale: Locale) -> String? {
        return nil
    }
}

struct TransferViewModelFactoryWrapper: TransferViewModelFactoryProtocol {
    let overriding: TransferViewModelFactoryOverriding
    let factory: TransferViewModelFactoryProtocol

    func createFeeViewModel(_ fee: Fee,
                            feeAsset: WalletAsset,
                            locale: Locale) -> FeeViewModelProtocol {
        overriding.createFeeViewModel(fee, feeAsset: feeAsset, locale: locale) ??
        factory.createFeeViewModel(fee, feeAsset: feeAsset, locale: locale)
    }

    func createAmountViewModel(for asset: WalletAsset,
                               sender: String?,
                               receiver: String?,
                               amount: Decimal?,
                               locale: Locale) -> AmountInputViewModelProtocol {
        overriding.createAmountViewModel(for: asset,
                                         sender: sender,
                                         receiver: receiver,
                                         amount: amount,
                                         locale: locale) ??
        factory.createAmountViewModel(for: asset,
                                      sender: sender,
                                      receiver: receiver,
                                      amount: amount,
                                      locale: locale)
    }

    func createDescriptionViewModel(for details: String?) throws -> DescriptionInputViewModelProtocol {
        try overriding.createDescriptionViewModel(for: details) ??
        (try factory.createDescriptionViewModel(for: details))
    }

    func createSelectedAssetViewModel(for asset: WalletAsset?,
                                      balanceData: BalanceData?,
                                      isSelecting: Bool,
                                      canSelect: Bool,
                                      locale: Locale) -> AssetSelectionViewModelProtocol {
        overriding.createSelectedAssetViewModel(for: asset,
                                                balanceData: balanceData,
                                                isSelecting: isSelecting,
                                                canSelect: canSelect,
                                                locale: locale) ??
        factory.createSelectedAssetViewModel(for: asset,
                                             balanceData: balanceData,
                                             isSelecting: isSelecting,
                                             canSelect: canSelect,
                                             locale: locale)
    }

    func createAssetSelectionTitle(_ asset: WalletAsset,
                                   balanceData: BalanceData?,
                                   locale: Locale) -> String {
        overriding.createAssetSelectionTitle(asset,
                                             balanceData: balanceData,
                                             locale: locale) ??
        factory.createAssetSelectionTitle(asset,
                                          balanceData: balanceData,
                                          locale: locale)
    }
}
