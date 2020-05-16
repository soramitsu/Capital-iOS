/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation

protocol TransferViewModelFactoryProtocol {
    func createFeeViewModel(_ fee: Fee,
                            feeAsset: WalletAsset,
                            locale: Locale) -> FeeViewModel

    func createAmountViewModel(for asset: WalletAsset,
                               sender: String?,
                               receiver: String?,
                               amount: Decimal?,
                               locale: Locale) -> AmountInputViewModel

    func createDescriptionViewModel(for details: String?) throws -> DescriptionInputViewModel
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

    func createAmountViewModel(for asset: WalletAsset,
                               sender: String?,
                               receiver: String?,
                               amount: Decimal?,
                               locale: Locale) -> AmountInputViewModel {

        let inputFormatter = amountFormatterFactory.createInputFormatter(for: asset)

        let localizedFormatter = inputFormatter.value(for: locale)

        let limit = transactionSettings.limitForAssetId(asset.identifier,
                                                        senderId: sender,
                                                        receiverId: receiver)

        return AmountInputViewModel(symbol: asset.symbol,
                                    amount: amount,
                                    limit: limits.maximum,
                                    formatter: localizedFormatter,
                                    precision: Int16(localizedFormatter.maximumFractionDigits))
    }

    func createDescriptionViewModel(for details: String?) throws -> DescriptionInputViewModel {
        guard let validator = descriptionValidatorFactory.createTransferDescriptionValidator() else {
                throw TransferViewModelFactoryError.missingValidator
        }

        if let details = details {
            _ = validator.didReceiveReplacement(details, for: NSRange(location: 0, length: 0))
        }

        return DescriptionInputViewModel(validator: validator)
    }
}
