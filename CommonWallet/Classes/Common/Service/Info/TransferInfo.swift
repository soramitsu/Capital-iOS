/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication

public struct TransferInfo {
    public var source: IRAccountId
    public var destination: IRAccountId
    public var amount: IRAmount
    public var asset: IRAssetId
    public var details: String
    public var feeAccountId: IRAccountId?
    public var fee: IRAmount?
}
