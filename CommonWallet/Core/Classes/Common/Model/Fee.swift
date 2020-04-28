/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public struct Fee: Codable, Equatable {
    public var value: AmountDecimal
    public var feeDescription: FeeDescription
}
