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
        case peerFirstName
        case peerLastName
        case details
        case amount
        case fee
        case timestamp
        case type
        case reason
    }

    public var transactionId: String
    public var status: AssetTransactionStatus
    public var assetId: String
    public var peerId: String
    public var peerFirstName: String?
    public var peerLastName: String?
    public var peerName: String?
    public var details: String
    public var amount: AmountDecimal
    public var fee: AmountDecimal?
    public var timestamp: Int64
    public var type: String
    public var reason: String?

    public init(transactionId: String,
                status: AssetTransactionStatus,
                assetId: String,
                peerId: String,
                peerFirstName: String?,
                peerLastName: String?,
                peerName: String?,
                details: String,
                amount: AmountDecimal,
                fee: AmountDecimal?,
                timestamp: Int64,
                type: String,
                reason: String?) {
        self.transactionId = transactionId
        self.status = status
        self.assetId = assetId
        self.peerId = peerId
        self.peerFirstName = peerFirstName
        self.peerLastName = peerLastName
        self.peerName = peerName
        self.details = details
        self.amount = amount
        self.fee = fee
        self.timestamp = timestamp
        self.type = type
        self.reason = reason
    }
}

public struct AssetTransactionPageData: Codable, Equatable {
    public var transactions: [AssetTransactionData]

    public init(transactions: [AssetTransactionData]) {
        self.transactions = transactions
    }
}
