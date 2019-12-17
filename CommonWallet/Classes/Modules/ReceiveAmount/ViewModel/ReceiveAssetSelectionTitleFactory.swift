/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

final class ReceiveAssetSelectionTitleFactory: AssetSelectionFactoryProtocol {
    
    func createTitle(for asset: WalletAsset?, balanceData: BalanceData?) -> String {
        guard let asset = asset else {
            return L10n.AssetSelection.noAsset
        }

        return "\(asset.identifier.name.uppercased()), \(asset.symbol)"
    }
    
}
