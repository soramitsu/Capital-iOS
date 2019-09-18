/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication

public struct TransferInfo {
    var source: IRAccountId
    var destination: IRAccountId
    var amount: IRAmount
    var asset: IRAssetId
    var details: String
    var feeAccountId: IRAccountId?
    var fee: IRAmount?
}
