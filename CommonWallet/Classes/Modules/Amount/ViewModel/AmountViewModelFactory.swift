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

    func createAmountViewModel(for asset: WalletAsset, amount: Decimal?, locale: Locale) -> AmountInputViewModel
    func createDescriptionViewModel() throws -> DescriptionInputViewModel
    func minimumLimit(for asset: WalletAsset) -> Decimal
    func createMinimumLimitErrorDetails(for asset: WalletAsset, locale: Locale) -> String
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
            return L10n.Amount.fee
        }

        let feeDisplaySettings = feeDisplaySettingsFactory
            .createFeeSettings(asset: asset, senderId: sender?.identifier(), receiverId: receiver?.identifier())

        let title = feeDisplaySettings.amountDetails.value(for: locale)

        guard let amount = amount else {
            return title
        }

        let amountFormatter = amountFormatterFactory.createDisplayFormatter(for: asset)

        guard let amountString = amountFormatter.value(for: locale)
            .string(from: amount as NSNumber) else {
            return title
        }

        return title + " \(asset.symbol)\(amountString)"
    }

    func createAmountViewModel(for asset: WalletAsset, amount: Decimal?, locale: Locale) -> AmountInputViewModel {
        let inputFormatter = amountFormatterFactory.createInputFormatter(for: asset)

        let localizedFormatter = inputFormatter.value(for: locale)

        let transactionSettings = transactionSettingsFactory.createSettings(for: asset)

        return AmountInputViewModel(amount: amount,
                                    limit: transactionSettings.transferLimit.maximum,
                                    formatter: localizedFormatter,
                                    precision: Int16(localizedFormatter.maximumFractionDigits))
    }

    func minimumLimit(for asset: WalletAsset) -> Decimal {
        return transactionSettingsFactory.createSettings(for: asset).transferLimit.minimum
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

    func createDescriptionViewModel() throws -> DescriptionInputViewModel {
        guard let validator = descriptionValidatorFactory.createTransferDescriptionValidator() else {
                throw AmountViewModelFactoryError.missingValidator
        }

        return DescriptionInputViewModel(title: L10n.Common.description,
                                         validator: validator)
    }
}
