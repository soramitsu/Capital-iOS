/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication


public enum AssetTransactionStatus: String, Codable {
    case pending = "PENDING"
    case commited = "COMMITTED"
    case rejected = "REJECTED"
}


public struct AssetTransactionData: Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case transactionId
        case status
        case assetId
        case peerId
        case peerName
        case details
        case amount
        case fee
        case timestamp
        case type
        case reason
    }

    var transactionId: String
    var status: AssetTransactionStatus
    var assetId: String
    var peerId: String
    var peerName: String
    var details: String
    var amount: String
    var fee: String?
    var timestamp: Int64
    var type: String
    var reason: String?
}

struct AssetTransactionPageData: Codable, Equatable {
    var transactions: [AssetTransactionData]
}
