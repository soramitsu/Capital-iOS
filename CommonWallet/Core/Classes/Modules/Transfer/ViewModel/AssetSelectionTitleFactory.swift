/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation

protocol AssetSelectionFactoryProtocol: class {
    func createTitle(for asset: WalletAsset?, balanceData: BalanceData?, locale: Locale) -> String
}

final class AssetSelectionFactory: AssetSelectionFactoryProtocol {
    let amountFormatterFactory: NumberFormatterFactoryProtocol

    init(amountFormatterFactory: NumberFormatterFactoryProtocol) {
        self.amountFormatterFactory = amountFormatterFactory
    }

    func createTitle(for asset: WalletAsset?, balanceData: BalanceData?, locale: Locale) -> String {
        guard let asset = asset else {
            return L10n.AssetSelection.noAsset
        }

        let amountFormatter = amountFormatterFactory.createDisplayFormatter(for: asset)

        let details = asset.details.value(for: locale)
        var title = "\(details) - \(asset.symbol)"

        if let balanceData = balanceData,
            let formattedBalance = amountFormatter.value(for: locale)
                .string(from: balanceData.balance.decimalValue as NSNumber) {
            title += formattedBalance
        }

        return title
    }
}
