/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation

protocol WithdrawAmountViewModelFactoryProtocol {
    func createWithdrawTitle() -> String
    func createFeeTitle(for asset: WalletAsset?, amount: Decimal?) -> String
    func createAmountViewModel() -> AmountInputViewModel
    func createDescriptionViewModel() throws -> DescriptionInputViewModel
    func createAccessoryViewModel(for asset: WalletAsset?, totalAmount: Decimal?) -> AccessoryViewModel
}

enum WithdrawAmountViewModelFactoryError: Error {
    case missingValidator
}

final class WithdrawAmountViewModelFactory {
    let option: WalletWithdrawOption
    let amountFormatter: NumberFormatter
    let amountLimit: Decimal
    let descriptionValidatorFactory: WalletInputValidatorFactoryProtocol

    init(amountFormatter: NumberFormatter,
         option: WalletWithdrawOption,
         amountLimit: Decimal,
         descriptionValidatorFactory: WalletInputValidatorFactoryProtocol) {
        self.amountFormatter = amountFormatter
        self.option = option
        self.amountLimit = amountLimit
        self.descriptionValidatorFactory = descriptionValidatorFactory
    }
}

extension WithdrawAmountViewModelFactory: WithdrawAmountViewModelFactoryProtocol {
    func createWithdrawTitle() -> String {
        return option.shortTitle
    }

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
        guard let validator = descriptionValidatorFactory
            .createWithdrawDescriptionValidator(optionId: option.identifier) else {
            throw WithdrawAmountViewModelFactoryError.missingValidator
        }

        return DescriptionInputViewModel(title: option.details,
                                         validator: validator)
    }

    func createAccessoryViewModel(for asset: WalletAsset?, totalAmount: Decimal?) -> AccessoryViewModel {
        let accessoryViewModel = AccessoryViewModel(title: "", action: "Next")

        guard let amount = totalAmount, let asset = asset else {
            return accessoryViewModel
        }

        guard let amountString = amountFormatter.string(from: amount as NSNumber) else {
            return accessoryViewModel
        }

        accessoryViewModel.title = "Total amount \(asset.symbol)\(amountString)"
        accessoryViewModel.numberOfLines = 2

        return accessoryViewModel
    }
}
