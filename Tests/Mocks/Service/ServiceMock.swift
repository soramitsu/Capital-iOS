/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import FireMock

enum FetchBalanceMock: ServiceMockProtocol {
    case success
    case single
    case error

    func mockFile() -> String {
        switch self {
        case .success:
            return "accounBalanceResponse.json"
        case .single:
            return "accountBalanceSingleResponse.json"
        case .error:
            return "irohaErrorResponse.json"
        }
    }
}

enum FetchHistoryMock: ServiceMockProtocol {
    case success
    case empty
    case small

    func mockFile() -> String {
        switch self {
        case .success:
            return "historyResponse.json"
        case .small:
            return "historySmallResponse.json"
        case .empty:
            return "historyEmptyResponse.json"
        }
    }
}

enum SearchMock: ServiceMockProtocol {
    case success
    case empty
    case invoice

    func mockFile() -> String {
        switch self {
        case .success:
            return "searchResponse.json"
        case .empty:
            return "searchEmptyResponse.json"
        case .invoice:
            return "searchInvoiceResponse.json"
        }
    }
}

enum TransferMock: ServiceMockProtocol {
    case success
    case invalidFormat

    func mockFile() -> String {
        switch self {
        case .success:
            return "successResultResponse.json"
        case .invalidFormat:
            return "transferFailResponse.json"
        }
    }
}

enum ContactsMock: ServiceMockProtocol {
    case success
    case empty
    
    func mockFile() -> String {
        switch self {
        case .success:
            return "contactsResponse.json"
        case .empty:
            return "searchEmptyResponse.json"
        }

    }
}
