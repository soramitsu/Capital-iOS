/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import XCTest
@testable import CommonWallet
import Cuckoo

class WithdrawServiceTests: NetworkBaseTests {
    func testWithdrawSuccess() throws {
        let info = try createRandomWithdrawInfo()
        let optionalResult = try performRequest(for: .success,
                                                info: info,
                                                errorFactory: nil)

        guard let result = optionalResult else {
            XCTFail("Unexpected nil result")
            return
        }

        if case .failure(let error) = result {
            XCTFail("Unexpected error \(error)")
        }
    }

    func testWithdrawWithDefaultErrorHandling() throws {
        let info = try createRandomWithdrawInfo()
        let optionalResult = try performRequest(for: .invalidFormat,
                                                info: info,
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

    func testWithdrawWithCustomErrorHandling() throws {
        let expectedError = MockNetworkError.withdrawError
        let info = try createRandomWithdrawInfo()
        let optionalResult = try performRequest(for: .invalidFormat,
                                                info: info,
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

    private func performRequest(for mock: WithdrawMock,
                                info: WithdrawInfo,
                                errorFactory: MiddlewareNetworkErrorFactoryProtocol?) throws -> Result<Void, Error>? {
        let networkResolver = MockMiddlewareNetworkResolverProtocol()

        let urlTemplateGetExpectation = XCTestExpectation()
        let adapterExpectation = XCTestExpectation()

        stub(networkResolver) { stub in
            when(stub).urlTemplate(for: any(MiddlewareRequestType.self)).then { requestType in
                XCTAssertEqual(requestType, .withdraw)

                urlTemplateGetExpectation.fulfill()

                return Constants.withdrawUrlTemplate
            }

            when(stub).adapter(for: any(MiddlewareRequestType.self)).then { requestType in
                XCTAssertEqual(requestType, .withdraw)

                adapterExpectation.fulfill()

                return nil
            }

            when(stub).errorFactory(for: any(MiddlewareRequestType.self)).then { requestType in
                XCTAssertEqual(requestType, .withdraw)

                return errorFactory
            }
        }

        try WithdrawMock.register(mock: mock,
                                  networkResolver: networkResolver,
                                  requestType: .withdraw,
                                  httpMethod: .post)

        let assetsCount = 4
        let accountSettings = try createRandomAccountSettings(for: assetsCount)
        let operationSettings = try createRandomOperationSettings()
        let operationFactory = MiddlewareOperationFactory(accountSettings: accountSettings,
                                                          operationSettings:  operationSettings,
                                                          networkResolver: networkResolver)
        let walletService = WalletService(operationFactory: operationFactory)

        let transferExpectation = XCTestExpectation()

        var result: Result<Void, Error>?

        walletService.withdraw(info: info, runCompletionIn: .main) { (optionalResult) in
            result = optionalResult

            transferExpectation.fulfill()
        }

        wait(for: [urlTemplateGetExpectation, adapterExpectation, transferExpectation],
             timeout: Constants.networkTimeout)

        return result
    }
}
