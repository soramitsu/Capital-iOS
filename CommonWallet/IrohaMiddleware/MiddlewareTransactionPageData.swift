/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public struct MiddlewareTransactionPageData: Codable, Equatable {
    public let transactions: [AssetTransactionData]

    public init(transactions: [AssetTransactionData]) {
        self.transactions = transactions
    }
}
