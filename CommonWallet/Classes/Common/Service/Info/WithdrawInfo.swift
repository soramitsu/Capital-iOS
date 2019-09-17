/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation
import IrohaCommunication

public struct WithdrawInfo {
    public var destinationAccountId: IRAccountId
    public var assetId: IRAssetId
    public var amount: IRAmount
    public var details: String
    public var feeAccountId: IRAccountId?
    public var fee: IRAmount?

    public init(destinationAccountId: IRAccountId,
                assetId: IRAssetId,
                amount: IRAmount,
                details: String,
                feeAccountId: IRAccountId?,
                fee: IRAmount?) {
        self.destinationAccountId = destinationAccountId
        self.assetId = assetId
        self.amount = amount
        self.details = details
        self.feeAccountId = feeAccountId
        self.fee = fee
    }
}
