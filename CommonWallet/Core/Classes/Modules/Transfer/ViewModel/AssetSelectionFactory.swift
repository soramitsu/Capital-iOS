/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation

protocol AssetSelectionFactoryProtocol: class {
    func createViewModel(for asset: WalletAsset?,
                         balanceData: BalanceData?,
                         locale: Locale,
                         isSelecting: Bool,
                         canSelect: Bool) -> AssetSelectionViewModel

    func createTitle(for asset: WalletAsset, balanceData: BalanceData?, locale: Locale) -> String
}

final class AssetSelectionFactory: AssetSelectionFactoryProtocol {
    let amountFormatterFactory: NumberFormatterFactoryProtocol

    init(amountFormatterFactory: NumberFormatterFactoryProtocol) {
        self.amountFormatterFactory = amountFormatterFactory
    }

    func createViewModel(for asset: WalletAsset?,
                         balanceData: BalanceData?,
                         locale: Locale,
                         isSelecting: Bool,
                         canSelect: Bool) -> AssetSelectionViewModel {
        var title: String = ""
        var details: String = ""

        if let asset = asset {
            title = asset.details.value(for: locale)

            let amountFormatter = amountFormatterFactory.createDisplayFormatter(for: asset)

            if let balanceData = balanceData,
                let formattedBalance = amountFormatter.value(for: locale)
                    .string(from: balanceData.balance.decimalValue as NSNumber) {
                details = "\(asset.symbol)\(formattedBalance)"
            }
        } else {
            title = L10n.AssetSelection.noAsset
        }

        return AssetSelectionViewModel(title: title,
                                       details: details,
                                       icon: nil,
                                       isSelecting: isSelecting,
                                       canSelect: canSelect)
    }

    func createTitle(for asset: WalletAsset, balanceData: BalanceData?, locale: Locale) -> String {
        let viewModel = createViewModel(for: asset,
                                        balanceData: balanceData,
                                        locale: locale,
                                        isSelecting: false,
                                        canSelect: false)

        if !viewModel.details.isEmpty {
            return "\(viewModel.title) - \(viewModel.details)"
        } else {
            return viewModel.title
        }
    }
}
