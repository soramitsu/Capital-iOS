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
    public var minValue: AmountDecimal?
    public var maxValue: AmountDecimal?

    public init(identifier: String,
                assetId: String,
                type: String,
                parameters: [AmountDecimal],
                accountId: String? = nil,
                minValue: AmountDecimal? = nil,
                maxValue: AmountDecimal? = nil) {
        self.identifier = identifier
        self.assetId = assetId
        self.type = type
        self.accountId = accountId
        self.parameters = parameters
        self.minValue = minValue
        self.maxValue = maxValue
    }
}

public extension FeeDescription {
    var userCanDefine: Bool {
        minValue != nil || maxValue != nil
    }
}
