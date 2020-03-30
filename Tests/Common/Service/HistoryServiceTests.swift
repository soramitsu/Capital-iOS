/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo
import IrohaCommunication

class HistoryServiceTests: NetworkBaseTests {

    func testHistorySuccess() throws {
        let transactionsPerPage: Int = 100
        let pagination = OffsetPagination(offset: 0, count: transactionsPerPage)
        let optionalResult = try performFetch(for: .success,
                                              pagination: pagination,
                                              errorFactory: nil)

        guard let result = optionalResult else {
            XCTFail("Unexpected nil result")
            return
        }

        if case .failure(let error) = result {
            XCTFail("Unexpected error \(error)")
        }
    }

    func testHistoryDefaultErrorHandling() throws {
        let transactionsPerPage: Int = 100
        let pagination = OffsetPagination(offset: 0, count: transactionsPerPage)
        let optionalResult = try performFetch(for: .error,
                                              pagination: pagination,
                                              errorFactory: nil)

        guard let result = optionalResult else {
            XCTFail("Unexpected nil result")
            return
        }

        guard case .failure(let error) = result, error is ResultStatusError else {
            XCTFail("Unexpected result \(result)")
            return
        }
    }

    func testHistoryCustomErrorHandling() throws {
        let transactionsPerPage: Int = 100
        let pagination = OffsetPagination(offset: 0, count: transactionsPerPage)

        let expectedError = MockNetworkError.historyError
        let optionalResult = try performFetch(for: .error,
                                              pagination: pagination,
                                              errorFactory: MockNetworkErrorFactory(defaultError: expectedError))

        guard let result = optionalResult else {
            XCTFail("Unexpected nil result")
            return
        }

        guard case .failure(let error) = result, let mockError = error as? MockNetworkError, mockError == expectedError else {
            XCTFail("Unexpected result \(result)")
            return
        }
    }

    // MARK: Private

    private func performFetch(for mock: FetchHistoryMock,
                              pagination: OffsetPagination,
                              errorFactory: WalletNetworkErrorFactoryProtocol?) throws
        -> Result<AssetTransactionPageData?, Error>? {

            let networkResolver = MockWalletNetworkResolverProtocol()

            let urlTemplateGetExpectation = XCTestExpectation()
            let adapterExpectation = XCTestExpectation()

            stub(networkResolver) { stub in
                when(stub).urlTemplate(for: any(WalletRequestType.self)).then { requestType in
                    XCTAssertEqual(requestType, .history)

                    urlTemplateGetExpectation.fulfill()

                    return Constants.historyUrlTemplate
                }

                when(stub).adapter(for: any(WalletRequestType.self)).then { requestType in
                    XCTAssertEqual(requestType, .history)

                    adapterExpectation.fulfill()

                    return nil
                }

                when(stub).errorFactory(for: any(WalletRequestType.self)).then { requestType in
                    XCTAssertEqual(requestType, .history)

                    return errorFactory
                }
            }

            try FetchHistoryMock.register(mock: mock,
                                          networkResolver: networkResolver,
                                          requestType: .history,
                                          httpMethod: .post,
                                          urlMockType: .regex)

            let assetsCount = 4
            let accountSettings = try createRandomAccountSettings(for: assetsCount)
            let operationFactory = MiddlewareOperationFactory(accountSettings: accountSettings,
                                                              networkResolver: networkResolver)
            let walletService = WalletService(operationFactory: operationFactory)

            let historyExpectation = XCTestExpectation()

            // when

            let assets = accountSettings.assets.map { $0.identifier }
            var filter = WalletHistoryRequest()
            filter.assets = assets

            var result: Result<AssetTransactionPageData?, Error>?

            walletService.fetchTransactionHistory(for: filter,
                                                  pagination: pagination,
                                                  runCompletionIn: .main) { (optionalResult) in
                                                    result = optionalResult

                                                    historyExpectation.fulfill()
            }

            // then

            wait(for: [urlTemplateGetExpectation, adapterExpectation, historyExpectation],
                 timeout: Constants.networkTimeout)

            return result
    }
}
