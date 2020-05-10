/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

final class ReceiveAssetSelectionFactory: AssetSelectionFactoryProtocol {

    func createViewModel(for asset: WalletAsset?,
                         balanceData: BalanceData?,
                         locale: Locale,
                         isSelecting: Bool,
                         canSelect: Bool) -> AssetSelectionViewModel {
        let title: String

        if let asset = asset {
            title = createTitle(for: asset, balanceData: balanceData, locale: locale)
        } else {
            title = L10n.AssetSelection.noAsset
        }

        return AssetSelectionViewModel(title: title,
                                       subtitle: "",
                                       details: "",
                                       icon: nil,
                                       isSelecting: isSelecting,
                                       canSelect: canSelect)
    }

    func createTitle(for asset: WalletAsset, balanceData: BalanceData?, locale: Locale) -> String {
        let name = asset.name.value(for: locale)

        if let platform = asset.platform?.value(for: locale) {
            return "\(platform) \(name), \(asset.symbol)"
        } else {
            return "\(name), \(asset.symbol)"
        }
    }
    
}
