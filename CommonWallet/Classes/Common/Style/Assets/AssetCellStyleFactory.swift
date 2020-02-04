/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol AssetCellStyleFactoryProtocol {
    func createCellStyle(for asset: WalletAsset) -> AssetCellStyle
}

struct AssetCellStyleFactory: AssetCellStyleFactoryProtocol {
    let style: WalletStyleProtocol

    func createCellStyle(for asset: WalletAsset) -> AssetCellStyle {
        return .card(CardAssetStyle.createDefaultCardStyle(with: style))
    }
}
