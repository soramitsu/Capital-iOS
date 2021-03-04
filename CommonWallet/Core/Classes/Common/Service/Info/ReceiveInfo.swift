/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


public struct ReceiveInfo: Codable, Equatable {

    public let accountId: String
    public let assetId: String?
    public var amount: AmountDecimal?
    public let details: String?

    public init(accountId: String, assetId: String?, amount: AmountDecimal?, details: String?) {
        self.accountId = accountId
        self.assetId = assetId
        self.amount = amount
        self.details = details
    }
}
