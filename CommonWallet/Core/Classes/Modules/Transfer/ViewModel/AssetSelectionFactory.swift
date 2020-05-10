/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation

public protocol AssetSelectionFactoryProtocol {
    func createViewModel(for asset: WalletAsset?,
                         balanceData: BalanceData?,
                         locale: Locale,
                         isSelecting: Bool,
                         canSelect: Bool) -> AssetSelectionViewModelProtocol

    func createTitle(for asset: WalletAsset, balanceData: BalanceData?, locale: Locale) -> String
}

struct AssetSelectionFactory: AssetSelectionFactoryProtocol {
    let amountFormatterFactory: NumberFormatterFactoryProtocol

    init(amountFormatterFactory: NumberFormatterFactoryProtocol) {
        self.amountFormatterFactory = amountFormatterFactory
    }

    func createViewModel(for asset: WalletAsset?,
                         balanceData: BalanceData?,
                         locale: Locale,
                         isSelecting: Bool,
                         canSelect: Bool) -> AssetSelectionViewModelProtocol {
        let title: String
        let subtitle: String
        let details: String

        if let asset = asset {

            if let platform = asset.platform?.value(for: locale) {
                title = platform
                subtitle = asset.name.value(for: locale)
            } else {
                title = asset.name.value(for: locale)
                subtitle = ""
            }

            let amountFormatter = amountFormatterFactory.createDisplayFormatter(for: asset)

            if let balanceData = balanceData,
                let formattedBalance = amountFormatter.value(for: locale)
                    .string(from: balanceData.balance.decimalValue as NSNumber) {
                details = "\(asset.symbol)\(formattedBalance)"
            } else {
                details = ""
            }
        } else {
            title = L10n.AssetSelection.noAsset
            subtitle = ""
            details = ""
        }

        return AssetSelectionViewModel(title: title,
                                       subtitle: subtitle,
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
