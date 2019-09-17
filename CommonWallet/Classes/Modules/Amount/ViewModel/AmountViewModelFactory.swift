/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

protocol AmountViewModelFactoryProtocol {
    func createFeeTitle(for asset: WalletAsset?, amount: Decimal?) -> String
    func createAmountViewModel() -> AmountInputViewModel
    func createDescriptionViewModel() throws -> DescriptionInputViewModel
}

enum AmountViewModelFactoryError: Error {
    case missingValidator
}

final class AmountViewModelFactory {
    let amountFormatter: NumberFormatter
    let amountLimit: Decimal
    let descriptionValidatorFactory: WalletInputValidatorFactoryProtocol

    init(amountFormatter: NumberFormatter,
         amountLimit: Decimal,
         descriptionValidatorFactory: WalletInputValidatorFactoryProtocol) {
        self.amountFormatter = amountFormatter
        self.amountLimit = amountLimit
        self.descriptionValidatorFactory = descriptionValidatorFactory
    }
}

extension AmountViewModelFactory: AmountViewModelFactoryProtocol {
    func createFeeTitle(for asset: WalletAsset?, amount: Decimal?) -> String {
        let title: String = "Transaction fee"

        guard let amount = amount, let asset = asset else {
            return title
        }

        guard let amountString = amountFormatter.string(from: amount as NSNumber) else {
            return title
        }

        return title + " \(asset.symbol)\(amountString)"
    }

    func createAmountViewModel() -> AmountInputViewModel {
        return AmountInputViewModel(optionalAmount: nil, limit: amountLimit)
    }

    func createDescriptionViewModel() throws -> DescriptionInputViewModel {
        guard let validator = descriptionValidatorFactory.createTransferDescriptionValidator() else {
                throw AmountViewModelFactoryError.missingValidator
        }

        return DescriptionInputViewModel(title: "Description",
                                         validator: validator)
    }
}
