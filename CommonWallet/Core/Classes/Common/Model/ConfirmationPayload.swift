/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public struct ConfirmationPayload {
    public let transferInfo: TransferInfo
    public let receiverName: String

    public init(transferInfo: TransferInfo, receiverName: String) {
        self.transferInfo = transferInfo
        self.receiverName = receiverName
    }
}
