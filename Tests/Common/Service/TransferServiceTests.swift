/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo

class TransferServiceTests: NetworkBaseTests {
    func testTransferSuccess() throws {
        let info = try createRandomTransferInfo()
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

    func testTransferWithDefaultErrorHandling() throws {
        let info = try createRandomTransferInfo()
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

    func testTransferWithCustomErrorHandling() throws {
        let expectedError = MockNetworkError.transferError
        let info = try createRandomTransferInfo()
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

    private func performRequest(for mock: TransferMock,
                                info: TransferInfo,
                                errorFactory: WalletNetworkErrorFactoryProtocol?) throws -> Result<Void, Error>? {
        let networkResolver = MockWalletNetworkResolverProtocol()

        let urlTemplateGetExpectation = XCTestExpectation()
        let adapterExpectation = XCTestExpectation()

        stub(networkResolver) { stub in
            when(stub).urlTemplate(for: any(WalletRequestType.self)).then { requestType in
                XCTAssertEqual(requestType, .transfer)

                urlTemplateGetExpectation.fulfill()

                return Constants.transferUrlTemplate
            }

            when(stub).adapter(for: any(WalletRequestType.self)).then { requestType in
                XCTAssertEqual(requestType, .transfer)

                adapterExpectation.fulfill()

                return nil
            }

            when(stub).errorFactory(for: any(WalletRequestType.self)).then { requestType in
                XCTAssertEqual(requestType, .transfer)

                return errorFactory
            }
        }

        try TransferMock.register(mock: mock,
                                  networkResolver: networkResolver,
                                  requestType: .transfer,
                                  httpMethod: .post)

        let assetsCount = 4
        let accountSettings = try createRandomAccountSettings(for: assetsCount)
        let operationFactory = MiddlewareOperationFactory(accountSettings: accountSettings,
                                                          networkResolver: networkResolver)
        let walletService = WalletService(operationFactory: operationFactory)

        let transferExpectation = XCTestExpectation()

        var result: Result<Void, Error>?

        walletService.transfer(info: info, runCompletionIn: .main) { (optionalResult) in
            result = optionalResult

            transferExpectation.fulfill()
        }

        wait(for: [urlTemplateGetExpectation, adapterExpectation, transferExpectation],
             timeout: Constants.networkTimeout)

        return result
    }
}
