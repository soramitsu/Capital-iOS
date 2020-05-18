/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public struct FeeCalculationResult {
    let sending: Decimal
    let fees: [Fee]
    let total: Decimal
}
