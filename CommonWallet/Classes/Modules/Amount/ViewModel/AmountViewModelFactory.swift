/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation
import IrohaCommunication

protocol AmountViewModelFactoryProtocol {
    func createFeeTitle(for asset: WalletAsset?,
                        sender: IRAccountId?,
                        receiver: IRAccountId?,
                        amount: Decimal?,
                        locale: Locale) -> String

    func createAmountViewModel(for asset: WalletAsset,
                               sender: IRAccountId?,
                               receiver: IRAccountId?,
                               amount: Decimal?,
                               locale: Locale) -> AmountInputViewModel

    func createDescriptionViewModel(for details: String?) throws -> DescriptionInputViewModel
    func minimumLimit(for asset: WalletAsset, sender: IRAccountId?, receiver: IRAccountId?) -> Decimal

    func createMinimumLimitErrorDetails(for asset: WalletAsset,
                                        sender: IRAccountId?,
                                        receiver: IRAccountId?,
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
    func createFeeTitle(for asset: WalletAsset?,
                        sender: IRAccountId?,
                        receiver: IRAccountId?,
                        amount: Decimal?,
                        locale: Locale) -> String {

        guard let asset = asset else {
            return L10n.Amount.defaultFee
        }

        let feeDisplaySettings = feeDisplaySettingsFactory
            .createFeeSettings(asset: asset, senderId: sender?.identifier(), receiverId: receiver?.identifier())

        guard let amount = amount else {
            return L10n.Amount.defaultFee
        }

        let amountFormatter = amountFormatterFactory.createDisplayFormatter(for: asset)

        guard let amountString = amountFormatter.value(for: locale)
            .string(from: amount as NSNumber) else {
            return L10n.Amount.defaultFee
        }

        let title = feeDisplaySettings.amountDetailsClosure("\(asset.symbol)\(amountString)", locale)

        return title
    }

    func createAmountViewModel(for asset: WalletAsset,
                               sender: IRAccountId?,
                               receiver: IRAccountId?,
                               amount: Decimal?,
                               locale: Locale) -> AmountInputViewModel {

        let inputFormatter = amountFormatterFactory.createInputFormatter(for: asset)

        let localizedFormatter = inputFormatter.value(for: locale)

        let transactionSettings = transactionSettingsFactory.createSettings(for: asset,
                                                                            senderId: sender?.identifier(),
                                                                            receiverId: receiver?.identifier())

        return AmountInputViewModel(amount: amount,
                                    limit: transactionSettings.transferLimit.maximum,
                                    formatter: localizedFormatter,
                                    precision: Int16(localizedFormatter.maximumFractionDigits))
    }

    func minimumLimit(for asset: WalletAsset, sender: IRAccountId?, receiver: IRAccountId?) -> Decimal {
        return transactionSettingsFactory
            .createSettings(for: asset, senderId: sender?.identifier(), receiverId: receiver?.identifier())
            .transferLimit.minimum
    }

    func createMinimumLimitErrorDetails(for asset: WalletAsset,
                                        sender: IRAccountId?,
                                        receiver: IRAccountId?,
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

        return DescriptionInputViewModel(title: L10n.Common.descriptionOptional,
                                         validator: validator)
    }
}
