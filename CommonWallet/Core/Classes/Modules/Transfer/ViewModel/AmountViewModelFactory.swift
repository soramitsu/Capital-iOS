/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation

protocol AmountViewModelFactoryProtocol {
    func createFeeViewModel(for asset: WalletAsset?,
                            sender: String?,
                            receiver: String?,
                            amount: Decimal?,
                            locale: Locale) -> FeeViewModel

    func createAmountViewModel(for asset: WalletAsset,
                               sender: String?,
                               receiver: String?,
                               amount: Decimal?,
                               locale: Locale) -> AmountInputViewModel

    func createDescriptionViewModel(for details: String?) throws -> DescriptionInputViewModel
    func minimumLimit(for asset: WalletAsset, sender: String?, receiver: String?) -> Decimal

    func createMinimumLimitErrorDetails(for asset: WalletAsset,
                                        sender: String?,
                                        receiver: String?,
                                        locale: Locale) -> String
}

enum AmountViewModelFactoryError: Error {
    case missingValidator
}

final class AmountViewModelFactory {
    let amountFormatterFactory: NumberFormatterFactoryProtocol
    let descriptionValidatorFactory: WalletInputValidatorFactoryProtocol
    let feeDisplaySettingsFactory: FeeDisplaySettingsFactoryProtocol
    let transactionSettingsFactory: WalletTransactionSettingsFactoryProtocol

    init(amountFormatterFactory: NumberFormatterFactoryProtocol,
         descriptionValidatorFactory: WalletInputValidatorFactoryProtocol,
         transactionSettingsFactory: WalletTransactionSettingsFactoryProtocol,
         feeDisplaySettingsFactory: FeeDisplaySettingsFactoryProtocol) {
        self.amountFormatterFactory = amountFormatterFactory
        self.descriptionValidatorFactory = descriptionValidatorFactory
        self.transactionSettingsFactory = transactionSettingsFactory
        self.feeDisplaySettingsFactory = feeDisplaySettingsFactory
    }
}

extension AmountViewModelFactory: AmountViewModelFactoryProtocol {
    func createFeeViewModel(for asset: WalletAsset?,
                            sender: String?,
                            receiver: String?,
                            amount: Decimal?,
                            locale: Locale) -> FeeViewModel {

        guard let asset = asset else {
            return FeeViewModel(title: L10n.Amount.defaultFee,
                                details: "",
                                isLoading: true,
                                allowsEditing: false)
        }

        let feeDisplaySettings = feeDisplaySettingsFactory
            .createFeeSettings(asset: asset, senderId: sender, receiverId: receiver)

        guard let amount = amount else {
            return FeeViewModel(title: L10n.Amount.defaultFee,
                                details: "",
                                isLoading: true,
                                allowsEditing: false)
        }

        let amountFormatter = amountFormatterFactory.createDisplayFormatter(for: asset)

        guard let amountString = amountFormatter.value(for: locale)
            .string(from: amount as NSNumber) else {
            return FeeViewModel(title: L10n.Amount.defaultFee,
                                details: "",
                                isLoading: true,
                                allowsEditing: false)
        }

        let details = "\(asset.symbol)\(amountString)"

        let title = feeDisplaySettings.amountDetailsClosure("", locale)

        return FeeViewModel(title: title, details: details, isLoading: false, allowsEditing: false)
    }

    func createAmountViewModel(for asset: WalletAsset,
                               sender: String?,
                               receiver: String?,
                               amount: Decimal?,
                               locale: Locale) -> AmountInputViewModel {

        let inputFormatter = amountFormatterFactory.createInputFormatter(for: asset)

        let localizedFormatter = inputFormatter.value(for: locale)

        let transactionSettings = transactionSettingsFactory.createSettings(for: asset,
                                                                            senderId: sender,
                                                                            receiverId: receiver)

        return AmountInputViewModel(symbol: asset.symbol,
                                    amount: amount,
                                    limit: transactionSettings.transferLimit.maximum,
                                    formatter: localizedFormatter,
                                    precision: Int16(localizedFormatter.maximumFractionDigits))
    }

    func minimumLimit(for asset: WalletAsset, sender: String?, receiver: String?) -> Decimal {
        return transactionSettingsFactory
            .createSettings(for: asset, senderId: sender, receiverId: receiver)
            .transferLimit.minimum
    }

    func createMinimumLimitErrorDetails(for asset: WalletAsset,
                                        sender: String?,
                                        receiver: String?,
                                        locale: Locale) -> String {
        let amount = minimumLimit(for: asset, sender: sender, receiver: receiver)

        let amountFormatter = amountFormatterFactory.createDisplayFormatter(for: asset)

        let amountString: String

        if let formattedAmount = amountFormatter.value(for: locale).string(from: amount as NSNumber) {
            amountString = formattedAmount
        } else {
            amountString = (amount as NSNumber).stringValue
        }

        return L10n.Amount.Error.operationMinLimit("\(asset.symbol)\(amountString)")
    }

    func createDescriptionViewModel(for details: String?) throws -> DescriptionInputViewModel {
        guard let validator = descriptionValidatorFactory.createTransferDescriptionValidator() else {
                throw AmountViewModelFactoryError.missingValidator
        }

        if let details = details {
            _ = validator.didReceiveReplacement(details, for: NSRange(location: 0, length: 0))
        }

        return DescriptionInputViewModel(validator: validator)
    }
}
