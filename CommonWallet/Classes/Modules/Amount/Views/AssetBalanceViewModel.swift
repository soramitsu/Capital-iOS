/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


struct AssetBalanceViewModel {
    var identifier: String
    var name: String
    var balance: String
    var symbol: String
    
    var title: String {
        return "\(name) - \(symbol) \(balance)"
    }
}
