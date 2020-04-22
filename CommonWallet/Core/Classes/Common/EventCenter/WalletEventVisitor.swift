/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

protocol WalletEventVisitorProtocol: class {
    func processTransferComplete(event: TransferCompleteEvent)
    func processWithdrawComplete(event: WithdrawCompleteEvent)
    func processAccountUpdate(event: AccountUpdateEvent)
}

extension WalletEventVisitorProtocol {
    func processTransferComplete(event: TransferCompleteEvent) {}
    func processWithdrawComplete(event: WithdrawCompleteEvent) {}
    func processAccountUpdate(event: AccountUpdateEvent) {}
}
