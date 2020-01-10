/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
@testable import CommonWallet

final class MoneyPresenter: MoneyPresentable {

    var amount: String = ""
    var formatter: NumberFormatter

    init(formatter: NumberFormatter = NumberFormatter.money) {
        self.formatter = formatter
    }
}
