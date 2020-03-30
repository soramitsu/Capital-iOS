/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo

class SearchServiceTests: NetworkBaseTests {

    func testSearchSuccess() throws {
        try performSearchTestSuccess(query: UUID().uuidString)
        try performSearchTestSuccess(query: "Поищи")
        try performSearchTestSuccess(query: "サーチ")
    }

    func testSearchWithDefaultErrorHandling() throws {
        let optionalResult = try performRequest(for: .error, query: "Search", errorFactory: nil)

        guard let result = optionalResult else {
            XCTFail("Unexpected nil result")
            return
        }

        guard case .failure(let error) = result, error is ResultStatusError else {
            XCTFail("Unexpected result \(result)")
            return
        }
    }

    func testSearchWithCustomErrorHandling() throws {
        let expectedError = MockNetworkError.searchError
        let optionalResult = try performRequest(for: .error,
                                                query: "Search",
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

    private func performSearchTestSuccess(query: String) throws {
        let optionalResult = try performRequest(for: .success,
                                                query: query,
                                                errorFactory: nil)

        guard let result = optionalResult else {
            XCTFail("Unexpected nil result")
            return
        }

        if case .failure(let error) = result {
            XCTFail("Unexpected error \(error)")
        }
    }

    private func performRequest(for mock: SearchMock,
                                query: String,
                                errorFactory: WalletNetworkErrorFactoryProtocol?) throws -> Result<[SearchData]?, Error>? {
        let networkResolver = MockWalletNetworkResolverProtocol()

        let urlTemplateGetExpectation = XCTestExpectation()
        let adapterExpectation = XCTestExpectation()

        stub(networkResolver) { stub in
            when(stub).urlTemplate(for: any(WalletRequestType.self)).then { requestType in
                XCTAssertEqual(requestType, .search)

                urlTemplateGetExpectation.fulfill()

                return Constants.searchUrlTemplate
            }

            when(stub).adapter(for: any(WalletRequestType.self)).then { requestType in
                XCTAssertEqual(requestType, .search)

                adapterExpectation.fulfill()

                return nil
            }

            when(stub).errorFactory(for: any(WalletRequestType.self)).then { requestType in
                XCTAssertEqual(requestType, .search)

                return errorFactory
            }
        }

        try SearchMock.register(mock: mock,
                                networkResolver: networkResolver,
                                requestType: .search,
                                httpMethod: .get,
                                urlMockType: .regex)

        let assetsCount = 4
        let accountSettings = try createRandomAccountSettings(for: assetsCount)
        let operationFactory = MiddlewareOperationFactory(accountSettings: accountSettings,
                                                          networkResolver: networkResolver)
        let walletService = WalletService(operationFactory: operationFactory)

        let searchExpectation = XCTestExpectation()

        var result: Result<[SearchData]?, Error>?

        walletService.search(for: query, runCompletionIn: .main) { (optionalResult) in
            result = optionalResult

            searchExpectation.fulfill()
        }

        wait(for: [urlTemplateGetExpectation, adapterExpectation, searchExpectation],
             timeout: Constants.networkTimeout)

        return result
    }
}
