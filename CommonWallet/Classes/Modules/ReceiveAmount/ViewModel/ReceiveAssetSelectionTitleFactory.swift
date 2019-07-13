/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

final class ReceiveAssetSelectionTitleFactory: AssetSelectionFactoryProtocol {
    func createTitle(for asset: WalletAssetProtocol?, balanceData: BalanceData?) -> String {
        guard let asset = asset else {
            return "No asset"
        }

        return "\(asset.identifier.name.uppercased()), \(asset.symbol)"
    }
}
