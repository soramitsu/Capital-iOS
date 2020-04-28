/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public struct FeeDescription: Codable, Equatable {
    public var identifier: String
    public var assetId: String
    public var type: String
    public var parameters: [AmountDecimal]
    public var accountId: String?
    public var min: AmountDecimal?
    public var max: AmountDecimal?

    public init(identifier: String,
                assetId: String,
                type: String,
                parameters: [AmountDecimal],
                accountId: String? = nil,
                min: AmountDecimal? = nil,
                max: AmountDecimal? = nil) {
        self.identifier = identifier
        self.assetId = assetId
        self.type = type
        self.accountId = accountId
        self.parameters = parameters
        self.min = min
        self.max = max
    }
}
