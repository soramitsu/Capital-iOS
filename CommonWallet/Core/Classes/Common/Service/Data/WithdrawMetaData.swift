/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public struct WithdrawMetaData: Codable, Equatable {
    public let providerAccountId: String
    public let feeDescriptions: [FeeDescription]

    public init(providerAccountId: String, feeDescriptions: [FeeDescription]) {
        self.providerAccountId = providerAccountId
        self.feeDescriptions = feeDescriptions
    }
}
