/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol AssetViewModelProtocol: WalletViewModelProtocol {
    var assetId: String { get }
    var amount: String { get }
    var symbol: String? { get }
    var details: String { get }
    var accessoryDetails: String? { get }
    var imageViewModel: WalletImageViewModelProtocol? { get }
    var style: AssetCellStyle { get }
}

final class AssetViewModel: AssetViewModelProtocol {
    var cellReuseIdentifier: String

    var itemHeight: CGFloat

    var assetId: String = ""
    var amount: String = ""
    var symbol: String?
    var details: String = ""
    var accessoryDetails: String?
    var imageViewModel: WalletImageViewModelProtocol?
    var style: AssetCellStyle

    var command: WalletCommandProtocol?

    init(cellReuseIdentifier: String, itemHeight: CGFloat, style: AssetCellStyle, command: WalletCommandProtocol?) {
        self.cellReuseIdentifier = cellReuseIdentifier
        self.itemHeight = itemHeight
        self.style = style
        self.command = command
    }
}
