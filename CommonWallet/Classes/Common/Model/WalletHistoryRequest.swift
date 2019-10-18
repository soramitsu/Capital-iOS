/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication


public struct WalletHistoryRequest {
    
    public var assets: [IRAssetId]?
    public var filter: String?
    public var fromDate: Date?
    public var toDate: Date?
    public var type: String?
    
    public init(assets: [IRAssetId]) {
        self.assets = assets
    }
    
    public init() {}
        
}


extension WalletHistoryRequest: Codable {
    
    enum CodingKeys: String, CodingKey {
        
        case assets
        case filter
        case fromDate
        case toDate
        case type
        
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        filter = try container.decodeIfPresent(String.self, forKey: .filter)
        fromDate = try container.decodeIfPresent(Date.self, forKey: .fromDate)
        toDate = try container.decodeIfPresent(Date.self, forKey: .toDate)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        
        if let assetList = try container.decodeIfPresent([String].self, forKey: .assets) {
            assets = try assetList.map { try IRAssetIdFactory.asset(withIdentifier: $0) }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(filter, forKey: .filter)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(fromDate, forKey: .fromDate)
        try container.encodeIfPresent(toDate, forKey: .toDate)
        
        if let assets = assets {
            try container.encodeIfPresent(assets.map { $0.identifier() }, forKey: .assets)
        }
    }
    
}


extension WalletHistoryRequest: Equatable {
    
    public static func == (lhs: WalletHistoryRequest, rhs: WalletHistoryRequest) -> Bool {
        let leftAssets = lhs.assets?.map { $0.identifier() }.sorted()
        let rightAssets = rhs.assets?.map { $0.identifier() }.sorted()
        
        return
            lhs.type == rhs.type &&
            lhs.filter == rhs.filter &&
            lhs.fromDate == rhs.fromDate &&
            lhs.toDate == rhs.toDate &&
            lhs.filter == rhs.filter &&
            leftAssets == rightAssets
        
    }

}
