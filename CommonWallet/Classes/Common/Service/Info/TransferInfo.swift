/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication

public struct TransferInfo {
    public var source: IRAccountId
    public var destination: IRAccountId
    public var amount: IRAmount
    public var asset: IRAssetId
    public var details: String
    public var feeAccountId: IRAccountId?
    public var fee: IRAmount?

    public init(source: IRAccountId,
                destination: IRAccountId,
                amount: IRAmount,
                asset: IRAssetId,
                details: String,
                feeAccountId: IRAccountId?,
                fee: IRAmount?) {
        self.source = source
        self.destination = destination
        self.amount = amount
        self.asset = asset
        self.details = details
        self.feeAccountId = feeAccountId
        self.fee = fee
    }
}
