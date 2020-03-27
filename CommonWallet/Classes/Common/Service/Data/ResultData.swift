/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

enum ResultDataError: Error {
    case missingStatusField
    case unexpectedNumberOfFields
}

struct StatusData: Decodable {
    var code: String
    var message: String

    var isSuccess: Bool {
        return code == "OK"
    }
}

struct ResultData<ResultType> where ResultType: Decodable {
    var status: StatusData
    var result: ResultType?
}

extension ResultData: Decodable {
    enum CodingKeys: String, CodingKey {
        case status
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKey.self)

        guard container.allKeys.count > 0, container.allKeys.count < 3 else {
            throw ResultDataError.unexpectedNumberOfFields
        }

        guard let statusKey = DynamicCodingKey(stringValue: CodingKeys.status.rawValue) else {
            throw ResultDataError.missingStatusField
        }

        status = try container.decode(StatusData.self, forKey: statusKey)

        if let resultKey = container.allKeys.first(where: { $0.stringValue != CodingKeys.status.stringValue }) {
            result = try container.decode(ResultType.self, forKey: resultKey)
        }
    }
}

struct MultifieldResultData<ResultType> where ResultType: Decodable {
    var status: StatusData
    var result: ResultType?
}

extension MultifieldResultData: Decodable {
    enum CodingKeys: String, CodingKey {
        case status
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKey.self)

        guard let statusKey = DynamicCodingKey(stringValue: CodingKeys.status.rawValue) else {
            throw ResultDataError.missingStatusField
        }

        status = try container.decode(StatusData.self, forKey: statusKey)

        if container.allKeys.count > 1 {
            result = try ResultType(from: decoder)
        }
    }
}
