/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

protocol AssetSelectionFactoryProtocol: class {
    func createTitle(for asset: WalletAsset?, balanceData: BalanceData?) -> String
}

final class AssetSelectionFactory: AssetSelectionFactoryProtocol {
    var amountFormatter: NumberFormatter

    init(amountFormatter: NumberFormatter) {
        self.amountFormatter = amountFormatter
    }

    func createTitle(for asset: WalletAsset?, balanceData: BalanceData?) -> String {
        guard let asset = asset else {
            return "No asset"
        }

        var title = "\(asset.details) - \(asset.symbol)"

        if let balanceData = balanceData,
            let value = Decimal(string: balanceData.balance),
            let formattedBalance = amountFormatter.string(from: value as NSNumber) {
            title += formattedBalance
        }

        return title
    }
}
