/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import XCTest
@testable import CommonWallet
import Cuckoo

class WithdrawalMetadataServiceTests: NetworkBaseTests {

    func testWithdrawalMetadataSuccess() throws {
        let info = try createRandomWithdrawMetadataInfo()
        let optionalResult = try performFetch(for: .success,
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

    func testWithdrawMetadataWithDefaultErrorHandling() throws {
        let info = try createRandomWithdrawMetadataInfo()
        let optionalResult = try performFetch(for: .notAvailable,
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
        let expectedError = MockNetworkError.withdrawalMetadataError
        let info = try createRandomWithdrawMetadataInfo()
        let optionalResult = try performFetch(for: .notAvailable,
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

    private func performFetch(for mock: WithdrawalMetadataMock,
                              info: WithdrawMetadataInfo,
                              errorFactory: WalletNetworkErrorFactoryProtocol?) throws -> Result<WithdrawMetaData?, Error>? {
        let networkResolver = MockWalletNetworkResolverProtocol()

        let urlTemplateGetExpectation = XCTestExpectation()
        let adapterExpectation = XCTestExpectation()

        stub(networkResolver) { stub in
            when(stub).urlTemplate(for: any(WalletRequestType.self)).then { requestType in
                XCTAssertEqual(requestType, .withdrawalMetadata)

                urlTemplateGetExpectation.fulfill()

                return Constants.withdrawalMetadataUrlTemplate
            }

            when(stub).adapter(for: any(WalletRequestType.self)).then { requestType in
                XCTAssertEqual(requestType, .withdrawalMetadata)

                adapterExpectation.fulfill()

                return nil
            }

            when(stub).errorFactory(for: any(WalletRequestType.self)).then { requestType in
                XCTAssertEqual(requestType, .withdrawalMetadata)

                return errorFactory
            }
        }

        try WithdrawalMetadataMock.register(mock: mock,
                                            networkResolver: networkResolver,
                                            requestType: .withdrawalMetadata,
                                            httpMethod: .get,
                                            urlMockType: .regex)

        let assetsCount = 4
        let accountSettings = try createRandomAccountSettings(for: assetsCount)
        let operationFactory = MiddlewareOperationFactory(accountSettings: accountSettings,
                                                          networkResolver: networkResolver)
        let walletService = WalletService(operationFactory: operationFactory)

        let completionExpectation = XCTestExpectation()

        var result: Result<WithdrawMetaData?, Error>?

        walletService.fetchWithdrawalMetadata(for: info, runCompletionIn: .main) { (optionalResult) in
            result = optionalResult
            completionExpectation.fulfill()
        }

        wait(for: [urlTemplateGetExpectation, adapterExpectation, completionExpectation],
             timeout: Constants.networkTimeout)

        return result
    }
}
