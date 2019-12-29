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
    var amountFormatter: LocalizableResource<NumberFormatter>

    init(amountFormatter: LocalizableResource<NumberFormatter>) {
        self.amountFormatter = amountFormatter
    }

    func createTitle(for asset: WalletAsset?, balanceData: BalanceData?, locale: Locale) -> String {
        guard let asset = asset else {
            return L10n.AssetSelection.noAsset
        }

        var title = "\(asset.details) - \(asset.symbol)"

        if let balanceData = balanceData,
            let value = Decimal(string: balanceData.balance),
            let formattedBalance = amountFormatter.value(for: locale)
                .string(from: value as NSNumber) {
            title += formattedBalance
        }

        return title
    }
}
