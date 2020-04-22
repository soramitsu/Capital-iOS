/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

struct TransferPayload {
    var transferInfo: TransferInfo
    var receiverName: String
    var assetSymbol: String
}
