/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation

public struct WalletAsset {
    
    public let symbol: String
    public let name: LocalizableResource<String>
    public let identifier: String
    public let precision: Int16
    public let platform: LocalizableResource<String>?

    public init(identifier: String,
                name: LocalizableResource<String>,
                platform: LocalizableResource<String>? = nil,
                symbol: String,
                precision: Int16) {
        self.identifier = identifier
        self.name = name
        self.symbol = symbol
        self.precision = precision
        self.platform = platform
    }
    
}


extension WalletAsset: Hashable {
    
    public static func == (lhs: WalletAsset, rhs: WalletAsset) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
}
