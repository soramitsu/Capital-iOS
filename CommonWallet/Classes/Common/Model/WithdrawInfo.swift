/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation
import IrohaCommunication

struct WithdrawInfo {
    var destinationAccountId: IRAccountId
    var amount: IRAmount
    var details: String
    var feeAccountId: IRAccountId?
    var fee: IRAmount?
}
