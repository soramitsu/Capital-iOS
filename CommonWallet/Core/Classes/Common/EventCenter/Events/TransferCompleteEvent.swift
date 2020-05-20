/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

struct TransferCompleteEvent {
    let payload: ConfirmationPayload
}

extension TransferCompleteEvent: WalletEventProtocol {
    func accept(visitor: WalletEventVisitorProtocol) {
        visitor.processTransferComplete(event: self)
    }
}
