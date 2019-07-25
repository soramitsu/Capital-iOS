/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication

public typealias AssetViewModelFactory =
    (WalletAsset, BalanceData, AssetViewModelDelegate?) throws -> AssetViewModelProtocol

public protocol AssetViewModelProtocol: WalletViewModelProtocol {
    var assetId: String { get }
    var amount: String { get }
    var symbol: String { get }
    var details: String { get }
    var accessoryDetails: String? { get }
    var imageViewModel: WalletImageViewModelProtocol? { get }
    var style: AssetCellStyle { get }
}

public protocol AssetViewModelDelegate: class {
    func didSelect(assetViewModel: AssetViewModelProtocol)
}

final class AssetViewModel: AssetViewModelProtocol {
    var cellReuseIdentifier: String

    var itemHeight: CGFloat

    var assetId: String = ""
    var amount: String = ""
    var symbol: String = ""
    var details: String = ""
    var accessoryDetails: String?
    var imageViewModel: WalletImageViewModelProtocol?
    var style: AssetCellStyle

    weak var delegate: AssetViewModelDelegate?

    init(cellReuseIdentifier: String, itemHeight: CGFloat, style: AssetCellStyle) {
        self.cellReuseIdentifier = cellReuseIdentifier
        self.itemHeight = itemHeight
        self.style = style
    }

    func didSelect() {
        delegate?.didSelect(assetViewModel: self)
    }
}
