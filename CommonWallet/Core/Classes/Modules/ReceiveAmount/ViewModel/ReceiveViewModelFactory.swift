/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

protocol ReceiveViewModelFactoryProtocol: class {
    func createAmountViewModel(for asset: WalletAsset, amount: Decimal?, locale: Locale) -> AmountInputViewModel
    func createDescriptionViewModel(for details: String?) throws -> DescriptionInputViewModel

    func createSelectedAssetViewModel(for asset: WalletAsset?,
                                      balanceData: BalanceData?,
                                      selectedAssetState: SelectedAssetState,
                                      locale: Locale) -> AssetSelectionViewModelProtocol

    func createAssetSelectionTitle(_ asset: WalletAsset,
                                   balanceData: BalanceData?,
                                   locale: Locale) -> String
}

enum ReceiveViewModelFactoryError: Error {
    case missingValidator
}

final class ReceiveViewModelFactory: ReceiveViewModelFactoryProtocol {
    let amountFormatterFactory: NumberFormatterFactoryProtocol
    let descriptionValidatorFactory: WalletInputValidatorFactoryProtocol
    let transactionSettings: WalletTransactionSettingsProtocol

    init(amountFormatterFactory: NumberFormatterFactoryProtocol,
         descriptionValidatorFactory: WalletInputValidatorFactoryProtocol,
         transactionSettings: WalletTransactionSettingsProtocol) {
        self.amountFormatterFactory = amountFormatterFactory
        self.descriptionValidatorFactory = descriptionValidatorFactory
        self.transactionSettings = transactionSettings
    }

    func createAmountViewModel(for asset: WalletAsset, amount: Decimal?, locale: Locale) -> AmountInputViewModel {

        let inputFormatter = amountFormatterFactory.createInputFormatter(for: asset)

        let localizedFormatter = inputFormatter.value(for: locale)

        let limit = transactionSettings.limitForAssetId(asset.identifier, senderId: nil, receiverId: nil)

        return AmountInputViewModel(symbol: asset.symbol,
                                    amount: amount,
                                    limit: limit.maximum,
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

        return DescriptionInputViewModel(validator: validator)
    }

    func createSelectedAssetViewModel(for asset: WalletAsset?,
                                      balanceData: BalanceData?,
                                      selectedAssetState: SelectedAssetState,
                                      locale: Locale) -> AssetSelectionViewModelProtocol {
        let title: String

        if let asset = asset {
            title = createAssetSelectionTitle(asset, balanceData: balanceData, locale: locale)
        } else {
            title = L10n.AssetSelection.noAsset
        }

        return AssetSelectionViewModel(title: title,
                                       subtitle: "",
                                       details: "",
                                       icon: nil,
                                       state: selectedAssetState)
    }

    func createAssetSelectionTitle(_ asset: WalletAsset,
                                   balanceData: BalanceData?,
                                   locale: Locale) -> String {
        let name = asset.name.value(for: locale)

        if let platform = asset.platform?.value(for: locale) {
            return "\(platform) \(name), \(asset.symbol)"
        } else {
            return "\(name), \(asset.symbol)"
        }
    }
}
