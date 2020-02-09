/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
@testable import CommonWallet

final class MoneyPresenter: MoneyPresentable {

    var amount: String = ""
    var formatter: NumberFormatter
    var precision: Int16

    init(formatter: NumberFormatter = NumberFormatter.money(with: 2), precision: Int16 = 2) {
        self.formatter = formatter
        self.precision = precision
    }
}
