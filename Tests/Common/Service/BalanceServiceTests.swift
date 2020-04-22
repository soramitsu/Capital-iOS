/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo

class BalanceServiceTests: NetworkBaseTests {
    func testAccountBalanceSuccess() throws {
        let optionalResult = try performFetch(for: .success, errorFactory: nil)

        guard let result = optionalResult else {
            XCTFail("Unexpected nil result")
            return
        }

        if case .failure(let error) = result {
            XCTFail("Unexpected error \(error)")
        }
    }

    func testAccountBalanceWithDefaultErrorHandling() throws {
        let optionalResult = try performFetch(for: .error, errorFactory: nil)

        guard let result = optionalResult else {
            XCTFail("Unexpected nil result")
            return
        }

        guard case .failure(let error) = result, error is ResultStatusError else {
            XCTFail("Unexpected result \(result)")
            return
        }
    }

    func testAccountBalanceWithCustomErrorHandling() throws {
        let expectedError = MockNetworkError.balanceError
        let optionalResult = try performFetch(for: .error, errorFactory: MockNetworkErrorFactory(defaultError: expectedError))

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

    private func performFetch(for mock: FetchBalanceMock,
                              errorFactory: MiddlewareNetworkErrorFactoryProtocol?) throws -> Result<[BalanceData]?, Error>? {
        let networkResolver = MockMiddlewareNetworkResolverProtocol()

        let urlTemplateGetExpectation = XCTestExpectation()
        let adapterExpectation = XCTestExpectation()

        stub(networkResolver) { stub in
            when(stub).urlTemplate(for: any(MiddlewareRequestType.self)).then { requestType in
                XCTAssertEqual(requestType, .balance)

                urlTemplateGetExpectation.fulfill()

                return Constants.balanceUrlTemplate
            }

            when(stub).adapter(for: any(MiddlewareRequestType.self)).then { requestType in
                XCTAssertEqual(requestType, .balance)

                adapterExpectation.fulfill()

                return nil
            }

            when(stub).errorFactory(for: any(MiddlewareRequestType.self)).then { requestType in
                XCTAssertEqual(requestType, .balance)

                return errorFactory
            }
        }

        try FetchBalanceMock.register(mock: mock,
                                      networkResolver: networkResolver,
                                      requestType: .balance,
                                      httpMethod: .post)

        let assetsCount = 4
        let accountSettings = try createRandomAccountSettings(for: assetsCount)
        let operationSettings = try createRandomOperationSettings()
        let operationFactory = MiddlewareOperationFactory(accountSettings: accountSettings,
                                                          operationSettings: operationSettings,
                                                          networkResolver: networkResolver)
        let walletService = WalletService(operationFactory: operationFactory)

        let balanceExpectation = XCTestExpectation()

        // when

        var result: Result<[BalanceData]?, Error>? = nil
        let assets = accountSettings.assets.map { $0.identifier }
        walletService.fetchBalance(for: assets, runCompletionIn: .main) { (optionalResult) in
            result = optionalResult

            balanceExpectation.fulfill()
        }

        wait(for: [urlTemplateGetExpectation, adapterExpectation, balanceExpectation],
             timeout: Constants.networkTimeout)

        return result
    }
}
