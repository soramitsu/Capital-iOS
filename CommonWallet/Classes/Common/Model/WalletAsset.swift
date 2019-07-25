/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication


public struct WalletAsset {
    
    public var symbol: String
    public var details: String
    public var identifier: IRAssetId

    public init(identifier: IRAssetId, symbol: String, details: String) {
        self.identifier = identifier
        self.symbol = symbol
        self.details = details
    }
    
}


extension WalletAsset: Hashable {
    
    public static func == (lhs: WalletAsset, rhs: WalletAsset) -> Bool {
        return lhs.symbol == rhs.symbol
            && lhs.details == rhs.details
            && lhs.identifier.identifier() == rhs.identifier.identifier()
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(symbol)
        hasher.combine(details)
        hasher.combine(identifier.identifier())
    }
    
}
