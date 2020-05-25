/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public struct FeeCalculationResult {
    public let sending: Decimal
    public let fees: [Fee]
    public let total: Decimal

    public init(sending: Decimal, fees: [Fee], total: Decimal) {
        self.sending = sending
        self.fees = fees
        self.total = total
    }
}
