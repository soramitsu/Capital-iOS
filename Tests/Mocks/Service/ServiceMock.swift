/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

enum FetchBalanceMock: ServiceMockProtocol {
    case success
    case single
    case error

    var mockFile: String {
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
    case filter

    var mockFile: String {
        switch self {
        case .success:
            return "historyResponse.json"
        case .small:
            return "historySmallResponse.json"
        case .empty:
            return "historyEmptyResponse.json"
        case .filter:
            return "historyFilteredResponse.json"
        }
    }
}

enum SearchMock: ServiceMockProtocol {
    case success
    case empty
    case invoice

    var mockFile: String {
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

enum TransferMetadataMock: ServiceMockProtocol {
    case success
    case notAvailable

    var mockFile: String {
        switch self {
        case .success:
            return "transferMetadataResponse.json"
        case .notAvailable:
            return "feeNotAvailable.json"
        }
    }
}

enum TransferMock: ServiceMockProtocol {
    case success
    case invalidFormat

    var mockFile: String {
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
    
    var mockFile: String {
        switch self {
        case .success:
            return "contactsResponse.json"
        case .empty:
            return "searchEmptyResponse.json"
        }

    }
}

enum WithdrawalMetadataMock: ServiceMockProtocol {
    case success
    case notAvailable

    var mockFile: String {
        switch self {
        case .success:
            return "withdrawalMetadataResponse.json"
        case .notAvailable:
            return "feeNotAvailable.json"
        }
    }
}

enum WithdrawMock: ServiceMockProtocol {
    case success

    var mockFile: String {
        switch self {
        case .success:
            return "successResultResponse.json"
        }
    }
}
