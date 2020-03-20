/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

protocol ReceiveViewModelFactoryProtocol: class {
    func createAmountViewModel(for asset: WalletAsset, amount: Decimal?, locale: Locale) -> AmountInputViewModel
    func createDescriptionViewModel(for details: String?) throws -> DescriptionInputViewModel
}

enum ReceiveViewModelFactoryError: Error {
    case missingValidator
}

final class ReceiveViewModelFactory: ReceiveViewModelFactoryProtocol {
    let amountFormatterFactory: NumberFormatterFactoryProtocol
    let descriptionValidatorFactory: WalletInputValidatorFactoryProtocol
    let transactionSettingsFactory: WalletTransactionSettingsFactoryProtocol

    init(amountFormatterFactory: NumberFormatterFactoryProtocol,
         descriptionValidatorFactory: WalletInputValidatorFactoryProtocol,
         transactionSettingsFactory: WalletTransactionSettingsFactoryProtocol) {
        self.amountFormatterFactory = amountFormatterFactory
        self.descriptionValidatorFactory = descriptionValidatorFactory
        self.transactionSettingsFactory = transactionSettingsFactory
    }

    func createAmountViewModel(for asset: WalletAsset, amount: Decimal?, locale: Locale) -> AmountInputViewModel {

        let inputFormatter = amountFormatterFactory.createInputFormatter(for: asset)

        let localizedFormatter = inputFormatter.value(for: locale)

        let transactionSettings = transactionSettingsFactory.createSettings(for: asset,
                                                                            senderId: nil,
                                                                            receiverId: nil)

        return AmountInputViewModel(amount: amount,
                                    limit: transactionSettings.transferLimit.maximum,
                                    formatter: localizedFormatter,
                                    precision: Int16(localizedFormatter.maximumFractionDigits))
    }

    func createDescriptionViewModel(for details: String?) throws -> DescriptionInputViewModel {
        guard let validator = descriptionValidatorFactory.createReceiveDescriptionValidator() else {
                throw ReceiveViewModelFactoryError.missingValidator
        }

        if let details = details {
            _ = validator.didReceiveReplacement(details, for: NSRange(location: 0, length: 0))
        }

        return DescriptionInputViewModel(title: L10n.Common.description,
                                         validator: validator)
    }
}
