/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public struct TransferInfo {
    public var source: String
    public var destination: String
    public var amount: AmountDecimal
    public var asset: String
    public var details: String
    public var fees: [Fee]

    public init(source: String,
                destination: String,
                amount: AmountDecimal,
                asset: String,
                details: String,
                fees: [Fee]) {
        self.source = source
        self.destination = destination
        self.amount = amount
        self.asset = asset
        self.details = details
        self.fees = fees
    }
}
