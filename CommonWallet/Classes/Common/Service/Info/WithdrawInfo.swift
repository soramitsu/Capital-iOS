/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation
import IrohaCommunication

public struct WithdrawInfo {
    public var destinationAccountId: IRAccountId
    public var assetId: IRAssetId
    public var amount: IRAmount
    public var details: String
    public var feeAccountId: IRAccountId?
    public var fee: IRAmount?
}
