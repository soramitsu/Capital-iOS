/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication

public struct TransferMetadataInfo {
    public var assetId: IRAssetId
    public var sender: IRAccountId
    public var receiver: IRAccountId

    public init(assetId: IRAssetId, sender: IRAccountId, receiver: IRAccountId) {
        self.assetId = assetId
        self.sender = sender
        self.receiver = receiver
    }
}
