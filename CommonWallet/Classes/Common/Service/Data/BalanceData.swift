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

    var identifier: String
    var balance: String
}
