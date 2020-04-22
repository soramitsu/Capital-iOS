/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation

public struct WithdrawInfo {
    public var destinationAccountId: String
    public var assetId: String
    public var amount: AmountDecimal
    public var details: String
    public var feeAccountId: String?
    public var fee: AmountDecimal?

    public init(destinationAccountId: String,
                assetId: String,
                amount: AmountDecimal,
                details: String,
                feeAccountId: String?,
                fee: AmountDecimal?) {
        self.destinationAccountId = destinationAccountId
        self.assetId = assetId
        self.amount = amount
        self.details = details
        self.feeAccountId = feeAccountId
        self.fee = fee
    }
}
