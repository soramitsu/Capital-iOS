/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public struct TransferPayload {
    public let receiveInfo: ReceiveInfo
    public let receiverName: String

    public init(receiveInfo: ReceiveInfo, receiverName: String) {
        self.receiveInfo = receiveInfo
        self.receiverName = receiverName
    }
}
