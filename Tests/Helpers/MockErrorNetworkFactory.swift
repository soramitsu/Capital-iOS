/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
@testable import CommonWallet
import RobinHood

enum MockNetworkError: Error {
    case balanceError
    case transferError
    case transferMetadataError
    case historyError
    case searchError
    case contactsError
    case withdrawalMetadataError
    case withdrawError
}

extension MockNetworkError: WalletErrorContentConvertible {
    func toErrorContent(for locale: Locale?) -> WalletErrorContentProtocol {
        switch self {
        case .balanceError:
            return WalletErrorContent(title: "Error", message: "Balance Error")
        case .transferError:
            return WalletErrorContent(title: "Error", message: "Transfer Error")
        case .transferMetadataError:
            return WalletErrorContent(title: "Error", message: "Transfer Metadata Error")
        case .historyError:
            return WalletErrorContent(title: "Error", message: "History Error")
        case .searchError:
            return WalletErrorContent(title: "Error", message: "Search Error")
        case .contactsError:
            return WalletErrorContent(title: "Error", message: "Contacts Error")
        case .withdrawalMetadataError:
            return WalletErrorContent(title: "Error", message: "Withdraw Metadata Error")
        case .withdrawError:
            return WalletErrorContent(title: "Error", message: "Withdraw Error")
        }
    }
}

struct MockNetworkErrorFactory: MiddlewareNetworkErrorFactoryProtocol {
    let errorMapping: [String: Error] = [:]
    let defaultError: Error

    func createErrorFromStatus(_ status: String) -> Error {
        errorMapping[status] ?? defaultError
    }
}

struct MockErrorHandlingNetworkResolver: MiddlewareNetworkResolverProtocol {
    func urlTemplate(for type: MiddlewareRequestType) -> String {
        switch type {
        case .balance:
            return Constants.balanceUrlTemplate
        case .contacts:
            return Constants.contactsUrlTemplate
        case .history:
            return Constants.historyUrlTemplate
        case .search:
            return Constants.searchUrlTemplate
        case .transfer:
            return Constants.transferUrlTemplate
        case .transferMetadata:
            return Constants.transferMetadataUrlTemplate
        case .withdraw:
            return Constants.withdrawUrlTemplate
        case .withdrawalMetadata:
            return Constants.withdrawalMetadataUrlTemplate
        }
    }

    func adapter(for type: MiddlewareRequestType) -> NetworkRequestModifierProtocol? {
        nil
    }

    func errorFactory(for type: MiddlewareRequestType) -> MiddlewareNetworkErrorFactoryProtocol? {
        switch type {
        case .balance:
            return MockNetworkErrorFactory(defaultError: MockNetworkError.balanceError)
        case .contacts:
            return MockNetworkErrorFactory(defaultError: MockNetworkError.contactsError)
        case .history:
            return MockNetworkErrorFactory(defaultError: MockNetworkError.historyError)
        case .search:
            return MockNetworkErrorFactory(defaultError: MockNetworkError.searchError)
        case .transfer:
            return MockNetworkErrorFactory(defaultError: MockNetworkError.transferError)
        case .transferMetadata:
            return MockNetworkErrorFactory(defaultError: MockNetworkError.transferMetadataError)
        case .withdraw:
            return MockNetworkErrorFactory(defaultError: MockNetworkError.withdrawError)
        case .withdrawalMetadata:
            return MockNetworkErrorFactory(defaultError: MockNetworkError.withdrawalMetadataError)
        }
    }
}
