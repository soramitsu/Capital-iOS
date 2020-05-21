/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public struct TransferInfo {
    public let source: String
    public let destination: String
    public let amount: AmountDecimal
    public let asset: String
    public let details: String
    public let fees: [Fee]
    public let context: [String: String]?

    public init(source: String,
                destination: String,
                amount: AmountDecimal,
                asset: String,
                details: String,
                fees: [Fee],
                context: [String: String]? = nil) {
        self.source = source
        self.destination = destination
        self.amount = amount
        self.asset = asset
        self.details = details
        self.fees = fees
        self.context = context
    }
}
