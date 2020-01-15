/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation


struct TransferPayload {
    var transferInfo: TransferInfo
    var receiverName: String
    var assetSymbol: LocalizableResource<String>
}
