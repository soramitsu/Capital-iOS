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
                                       details: "",
                                       icon: nil,
                                       isSelecting: isSelecting,
                                       canSelect: canSelect)
    }

    func createTitle(for asset: WalletAsset, balanceData: BalanceData?, locale: Locale) -> String {
        let title = asset.details.value(for: locale)

        return "\(title), \(asset.symbol)"
    }
    
}
