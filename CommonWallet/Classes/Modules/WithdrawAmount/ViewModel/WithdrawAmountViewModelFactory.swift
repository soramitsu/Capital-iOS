/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation
import SoraFoundation
import IrohaCommunication

protocol WithdrawAmountViewModelFactoryProtocol {
    func createWithdrawTitle() -> String

    func createFeeTitle(for asset: WalletAsset?,
                        amount: Decimal?,
                        locale: Locale) -> String

    func createAmountViewModel(for asset: WalletAsset, amount: Decimal?, locale: Locale) -> AmountInputViewModel
    func createDescriptionViewModel() throws -> DescriptionInputViewModel
    func createAccessoryViewModel(for asset: WalletAsset?, totalAmount: Decimal?, locale: Locale) -> AccessoryViewModel
    func minimumLimit(for asset: WalletAsset) -> Decimal
    func createMinimumLimitErrorDetails(for asset: WalletAsset, locale: Locale) -> String
}

enum WithdrawAmountViewModelFactoryError: Error {
    case missingValidator
}

final class WithdrawAmountViewModelFactory {
    let amountFormatterFactory: NumberFormatterFactoryProtocol
    let option: WalletWithdrawOption
    let transactionSettingsFactory: WalletTransactionSettingsFactoryProtocol
    let descriptionValidatorFactory: WalletInputValidatorFactoryProtocol
    let feeDisplaySettingsFactory: FeeDisplaySettingsFactoryProtocol

    init(amountFormatterFactory: NumberFormatterFactoryProtocol,
         option: WalletWithdrawOption,
         descriptionValidatorFactory: WalletInputValidatorFactoryProtocol,
         transactionSettingsFactory: WalletTransactionSettingsFactoryProtocol,
         feeDisplaySettingsFactory: FeeDisplaySettingsFactoryProtocol) {
        self.amountFormatterFactory = amountFormatterFactory
        self.option = option
        self.descriptionValidatorFactory = descriptionValidatorFactory
        self.transactionSettingsFactory = transactionSettingsFactory
        self.feeDisplaySettingsFactory = feeDisplaySettingsFactory
    }
}

extension WithdrawAmountViewModelFactory: WithdrawAmountViewModelFactoryProtocol {
    func createWithdrawTitle() -> String {
        return option.shortTitle
    }

    func createFeeTitle(for asset: WalletAsset?,
                        amount: Decimal?,
                        locale: Locale) -> String {

        guard let asset = asset else {
            return L10n.Amount.defaultFee
        }

        let feeDisplaySettings = feeDisplaySettingsFactory.createFeeSettings(asset: asset,
                                                                             senderId: nil,
                                                                             receiverId: nil)

        guard let amount = amount else {
            return L10n.Amount.defaultFee
        }

        let amountFormatter = amountFormatterFactory.createDisplayFormatter(for: asset)

        guard let amountString = amountFormatter.value(for: locale)
            .string(from: amount as NSNumber) else {
            return L10n.Amount.defaultFee
        }

        let title: String = feeDisplaySettings.amountDetailsClosure("\(asset.symbol)\(amountString)", locale)

        return title
    }

    func createAmountViewModel(for asset: WalletAsset, amount: Decimal?, locale: Locale) -> AmountInputViewModel {
        let inputFormatter = amountFormatterFactory.createInputFormatter(for: asset)

        let localizedFormatter = inputFormatter.value(for: locale)

        let transactionSettings = transactionSettingsFactory.createSettings(for: asset,
                                                                            senderId: nil,
                                                                            receiverId: nil)

        return AmountInputViewModel(amount: amount,
                                    limit: transactionSettings.withdrawLimit.maximum,
                                    formatter: localizedFormatter,
                                    precision: Int16(localizedFormatter.maximumFractionDigits))
    }

    func createDescriptionViewModel() throws -> DescriptionInputViewModel {
        guard let validator = descriptionValidatorFactory
            .createWithdrawDescriptionValidator(optionId: option.identifier) else {
            throw WithdrawAmountViewModelFactoryError.missingValidator
        }

        return DescriptionInputViewModel(title: option.details,
                                         validator: validator)
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
        return transactionSettingsFactory.createSettings(for: asset,
                                                         senderId: nil,
                                                         receiverId: nil).withdrawLimit.minimum
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
}
