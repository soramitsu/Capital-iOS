/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public struct BalanceData: Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case balance
        case context
    }

    public let identifier: String
    public let balance: AmountDecimal
    public let context: [String: String]?

    public init(identifier: String, balance: AmountDecimal, context: [String: String]? = nil) {
        self.identifier = identifier
        self.balance = balance
        self.context = context
    }
}
