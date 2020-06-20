/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public struct AssetTransactionFee: Codable, Equatable {
    public let identifier: String
    public let assetId: String
    public let amount: AmountDecimal
    public let context: [String: String]?

    public init(identifier: String, assetId: String, amount: AmountDecimal, context: [String: String]?) {
        self.identifier = identifier
        self.assetId = assetId
        self.amount = amount
        self.context = context
    }
}
