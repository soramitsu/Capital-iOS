/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication
import SoraFoundation

public struct WalletAsset {
    
    public let symbol: String
    public let details: LocalizableResource<String>
    public let identifier: IRAssetId
    public let precision: Int16

    public init(identifier: IRAssetId,
                symbol: String,
                details: LocalizableResource<String>,
                precision: Int16) {
        self.identifier = identifier
        self.symbol = symbol
        self.details = details
        self.precision = precision
    }
    
}


extension WalletAsset: Hashable {
    
    public static func == (lhs: WalletAsset, rhs: WalletAsset) -> Bool {
        return lhs.identifier.identifier() == rhs.identifier.identifier()
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier.identifier())
    }
    
}
