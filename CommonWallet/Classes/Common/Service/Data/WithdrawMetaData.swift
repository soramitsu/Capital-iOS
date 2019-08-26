/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

struct WithdrawMetaData: Codable, Equatable {
    var providerAccountId: String
    var feeAccountId: String
    var feeRate: String
}

extension WithdrawMetaData {
    var feeRateDecimal: Decimal? {
        return Decimal(string: feeRate)
    }
}
