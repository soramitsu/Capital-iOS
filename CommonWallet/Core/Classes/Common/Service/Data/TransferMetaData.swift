/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public struct TransferMetaData: Codable, Equatable {
    public var feeAccountId: String?
    public var feeType: String
    public var feeRate: AmountDecimal

    public init(feeAccountId: String?, feeType: String, feeRate: AmountDecimal) {
        self.feeAccountId = feeAccountId
        self.feeType = feeType
        self.feeRate = feeRate
    }
}
