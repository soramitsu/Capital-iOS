/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public struct BalanceQueryInfo: Codable {
    public var assets: [String]
    public var query: Data

    public init(assets: [String], query: Data) {
        self.assets = assets
        self.query = query
    }
}
