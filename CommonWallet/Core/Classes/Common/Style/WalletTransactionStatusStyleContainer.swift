/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol WalletTransactionStatusStyleContainerProtocol {
    var approved: WalletTransactionStatusStyleProtocol { get }
    var pending: WalletTransactionStatusStyleProtocol { get }
    var rejected: WalletTransactionStatusStyleProtocol { get }
}

public struct WalletTransactionStatusStyleContainer: WalletTransactionStatusStyleContainerProtocol {
    public var approved: WalletTransactionStatusStyleProtocol
    public var pending: WalletTransactionStatusStyleProtocol
    public var rejected: WalletTransactionStatusStyleProtocol

    public init(approved: WalletTransactionStatusStyleProtocol,
                pending: WalletTransactionStatusStyleProtocol,
                rejected: WalletTransactionStatusStyleProtocol) {
        self.approved = approved
        self.pending = pending
        self.rejected = rejected
    }
}
