/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public struct TransactionInfo: Encodable {
    public let transaction: Data

    public init(transaction: Data) {
        self.transaction = transaction
    }
}
