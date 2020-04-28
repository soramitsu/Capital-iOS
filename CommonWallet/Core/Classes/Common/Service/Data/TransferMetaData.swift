/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public struct TransferMetaData: Codable, Equatable {
    public var feeDescriptions: [FeeDescription]

    public init(feeDescriptions: [FeeDescription]) {
        self.feeDescriptions = feeDescriptions
    }
}
