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
    case error

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
        case .error:
            return "irohaErrorResponse.json"
        }
    }
}

enum SearchMock: ServiceMockProtocol {
    case success
    case empty
    case invoice
    case error

    var mockFile: String {
        switch self {
        case .success:
            return "searchResponse.json"
        case .empty:
            return "searchEmptyResponse.json"
        case .invoice:
            return "searchInvoiceResponse.json"
        case .error:
            return "irohaErrorResponse.json"
        }
    }
}

enum TransferMetadataMock: ServiceMockProtocol {
    case success
    case factor
    case fixed
    case tax
    case notAvailable
    case error

    var mockFile: String {
        switch self {
        case .success:
            return "transferMetadataResponse.json"
        case .factor:
            return "transferMetadataFactorResponse.json"
        case .fixed:
            return "transferMetadataFixedResponse.json"
        case .tax:
            return "transferMetadataTaxResponse.json"
        case .notAvailable:
            return "feeNotAvailable.json"
        case .error:
            return "irohaErrorResponse.json"
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
    case error
    
    var mockFile: String {
        switch self {
        case .success:
            return "contactsResponse.json"
        case .empty:
            return "searchEmptyResponse.json"
        case .error:
            return "irohaErrorResponse.json"
        }

    }
}

enum WithdrawalMetadataMock: ServiceMockProtocol {
    case success
    case factor
    case fixed
    case tax
    case notAvailable

    var mockFile: String {
        switch self {
        case .success:
            return "withdrawalMetadataResponse.json"
        case .factor:
            return "withdrawalMetadataFactorResponse.json"
        case .fixed:
            return "withdrawalMetadataFixedResponse.json"
        case .tax:
            return "withdrawalMetadataTaxResponse.json"
        case .notAvailable:
            return "feeNotAvailable.json"
        }
    }
}

enum WithdrawMock: ServiceMockProtocol {
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
