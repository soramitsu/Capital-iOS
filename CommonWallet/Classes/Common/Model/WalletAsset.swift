/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication

public protocol WalletAssetProtocol {
    var symbol: String { get }
    var details: String { get }
    var identifier: IRAssetId { get }
}

public struct WalletAsset: WalletAssetProtocol {
    public var symbol: String
    public var details: String
    public var identifier: IRAssetId

    public init(identifier: IRAssetId, symbol: String, details: String) {
        self.identifier = identifier
        self.symbol = symbol
        self.details = details
    }
}
