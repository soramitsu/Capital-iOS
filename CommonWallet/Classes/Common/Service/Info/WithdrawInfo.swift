/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation
import IrohaCommunication

public struct WithdrawInfo {
    var destinationAccountId: IRAccountId
    var assetId: IRAssetId
    var amount: IRAmount
    var details: String
    var feeAccountId: IRAccountId?
    var fee: IRAmount?
}
