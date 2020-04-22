/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public struct BalanceData: Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case balance
    }

    public var identifier: String
    public var balance: AmountDecimal

    public init(identifier: String, balance: AmountDecimal) {
        self.identifier = identifier
        self.balance = balance
    }
}
