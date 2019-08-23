/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

extension NumberFormatter {
    static var amount: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.roundingMode = .ceiling
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.alwaysShowsDecimalSeparator = false
        return numberFormatter
    }
}
