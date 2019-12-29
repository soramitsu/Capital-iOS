/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation

protocol AmountViewModelFactoryProtocol {
    func createFeeTitle(for asset: WalletAsset?, amount: Decimal?, locale: Locale) -> String
    func createAmountViewModel(with optionalAmount: Decimal?) -> AmountInputViewModel
    func createDescriptionViewModel() throws -> DescriptionInputViewModel
}

enum AmountViewModelFactoryError: Error {
    case missingValidator
}

final class AmountViewModelFactory {
    let amountFormatter: LocalizableResource<NumberFormatter>
    let amountLimit: Decimal
    let descriptionValidatorFactory: WalletInputValidatorFactoryProtocol

    init(amountFormatter: LocalizableResource<NumberFormatter>,
         amountLimit: Decimal,
         descriptionValidatorFactory: WalletInputValidatorFactoryProtocol) {
        self.amountFormatter = amountFormatter
        self.amountLimit = amountLimit
        self.descriptionValidatorFactory = descriptionValidatorFactory
    }
}

extension AmountViewModelFactory: AmountViewModelFactoryProtocol {
    func createFeeTitle(for asset: WalletAsset?, amount: Decimal?, locale: Locale) -> String {
        let title: String = L10n.Amount.fee

        guard let amount = amount, let asset = asset else {
            return title
        }

        guard let amountString = amountFormatter.value(for: locale)
            .string(from: amount as NSNumber) else {
            return title
        }

        return title + " \(asset.symbol)\(amountString)"
    }

    func createAmountViewModel(with optionalAmount: Decimal?) -> AmountInputViewModel {
        return AmountInputViewModel(amount: optionalAmount, limit: amountLimit)
    }

    func createDescriptionViewModel() throws -> DescriptionInputViewModel {
        guard let validator = descriptionValidatorFactory.createTransferDescriptionValidator() else {
                throw AmountViewModelFactoryError.missingValidator
        }

        return DescriptionInputViewModel(title: L10n.Common.description,
                                         validator: validator)
    }
}
