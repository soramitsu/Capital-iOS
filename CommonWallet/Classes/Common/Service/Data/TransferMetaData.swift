/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public struct TransferMetaData: Codable, Equatable {
    var feeAccountId: String?
    var feeType: String
    var feeRate: String
}

public extension TransferMetaData {
    var feeRateDecimal: Decimal? {
        return Decimal(string: feeRate)
    }
}
