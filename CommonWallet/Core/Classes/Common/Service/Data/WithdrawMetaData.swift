/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public struct WithdrawMetaData: Codable, Equatable {
    public var providerAccountId: String
    public var feeAccountId: String?
    public var feeType: String
    public var feeRate: AmountDecimal

    public init(providerAccountId: String, feeAccountId: String?, feeType: String, feeRate: AmountDecimal) {
        self.providerAccountId = providerAccountId
        self.feeAccountId = feeAccountId
        self.feeType = feeType
        self.feeRate = feeRate
    }
}
