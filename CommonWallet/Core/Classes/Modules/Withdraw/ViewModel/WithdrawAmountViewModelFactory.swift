/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation
import SoraFoundation

protocol WithdrawAmountViewModelFactoryProtocol {

    func createFeeViewModel(_ fee: Fee,
                            feeAsset: WalletAsset,
                            locale: Locale) -> FeeViewModel

    func createAmountViewModel(for asset: WalletAsset, amount: Decimal?, locale: Locale) -> AmountInputViewModel
    func createDescriptionViewModel() throws -> DescriptionInputViewModel
    func createAccessoryViewModel(for asset: WalletAsset?, totalAmount: Decimal?, locale: Locale) -> AccessoryViewModel
    func minimumLimit(for asset: WalletAsset) -> Decimal
    func createMinimumLimitErrorDetails(for asset: WalletAsset, locale: Locale) -> String

    func createSelectedAssetViewModel(for asset: WalletAsset?,
                                      balanceData: BalanceData?,
                                      isSelecting: Bool,
                                      canSelect: Bool,
                                      locale: Locale) -> AssetSelectionViewModelProtocol

    func createAssetSelectionTitle(_ asset: WalletAsset,
                                   balanceData: BalanceData?,
                                   locale: Locale) -> String
}

enum WithdrawAmountViewModelFactoryError: Error {
    case missingValidator
}

final class WithdrawAmountViewModelFactory {
    let amountFormatterFactory: NumberFormatterFactoryProtocol
    let option: WalletWithdrawOption
    let transactionSettings: WalletTransactionSettingsProtocol
    let descriptionValidatorFactory: WalletInputValidatorFactoryProtocol
    let feeDisplaySettingsFactory: FeeDisplaySettingsFactoryProtocol

    init(amountFormatterFactory: NumberFormatterFactoryProtocol,
         option: WalletWithdrawOption,
         descriptionValidatorFactory: WalletInputValidatorFactoryProtocol,
         transactionSettings: WalletTransactionSettingsProtocol,
         feeDisplaySettingsFactory: FeeDisplaySettingsFactoryProtocol) {
        self.amountFormatterFactory = amountFormatterFactory
        self.option = option
        self.descriptionValidatorFactory = descriptionValidatorFactory
        self.transactionSettings = transactionSettings
        self.feeDisplaySettingsFactory = feeDisplaySettingsFactory
    }
}

extension WithdrawAmountViewModelFactory: WithdrawAmountViewModelFactoryProtocol {

    func createFeeViewModel(_ fee: Fee,
                            feeAsset: WalletAsset,
                            locale: Locale) -> FeeViewModel {

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

    func createAmountViewModel(for asset: WalletAsset, amount: Decimal?, locale: Locale) -> AmountInputViewModel {
        let inputFormatter = amountFormatterFactory.createInputFormatter(for: asset)

        let localizedFormatter = inputFormatter.value(for: locale)

        let limit = transactionSettings.limitForAssetId(asset.identifier,
                                                        senderId: nil,
                                                        receiverId: nil)

        return AmountInputViewModel(symbol: asset.symbol,
                                    amount: amount,
                                    limit: limit.maximum,
                                    formatter: localizedFormatter,
                                    precision: Int16(localizedFormatter.maximumFractionDigits))
    }

    func createDescriptionViewModel() throws -> DescriptionInputViewModel {
        guard let validator = descriptionValidatorFactory
            .createWithdrawDescriptionValidator(optionId: option.identifier) else {
            throw WithdrawAmountViewModelFactoryError.missingValidator
        }

        return DescriptionInputViewModel(validator: validator)
    }

    func createAccessoryViewModel(for asset: WalletAsset?,
                                  totalAmount: Decimal?,
                                  locale: Locale) -> AccessoryViewModel {
        let accessoryViewModel = AccessoryViewModel(title: "", action: L10n.Common.next)

        guard let amount = totalAmount, let asset = asset else {
            return accessoryViewModel
        }

        let amountFormatter = amountFormatterFactory.createDisplayFormatter(for: asset)

        guard let amountString = amountFormatter.value(for: locale).string(from: amount as NSNumber) else {
            return accessoryViewModel
        }

        accessoryViewModel.title = L10n.Withdraw.totalAmount(asset.symbol,
                                                             amountString)
        accessoryViewModel.numberOfLines = 2

        return accessoryViewModel
    }

    func minimumLimit(for asset: WalletAsset) -> Decimal {
        return transactionSettings.limitForAssetId(asset.identifier,
                                                   senderId: nil,
                                                   receiverId: nil).minimum
    }

    func createMinimumLimitErrorDetails(for asset: WalletAsset, locale: Locale) -> String {
        let amount = minimumLimit(for: asset)

        let amountFormatter = amountFormatterFactory.createDisplayFormatter(for: asset)

        let amountString: String

        if let formattedAmount = amountFormatter.value(for: locale).string(from: amount as NSNumber) {
            amountString = formattedAmount
        } else {
            amountString = (amount as NSNumber).stringValue
        }

        return L10n.Amount.Error.operationMinLimit("\(asset.symbol)\(amountString)")
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
