/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo

class TransferMetadataServiceTests: NetworkBaseTests {
    func testTransferMetadataSuccess() throws {
        let info = try createRandomTransferMetadataInfo()

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

    func testTransferMetadataWithDefaultErrorHandling() throws {
        let info = try createRandomTransferMetadataInfo()
        let optionalResult = try performFetch(for: .error,
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
        let expectedError = MockNetworkError.transferMetadataError
        let info = try createRandomTransferMetadataInfo()
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

    private func performFetch(for mock: TransferMetadataMock,
                              info: TransferMetadataInfo,
                              errorFactory: MiddlewareNetworkErrorFactoryProtocol?) throws -> Result<TransferMetaData?, Error>? {
        let networkResolver = MockMiddlewareNetworkResolverProtocol()

        let urlTemplateGetExpectation = XCTestExpectation()
        let adapterExpectation = XCTestExpectation()

        stub(networkResolver) { stub in
            when(stub).urlTemplate(for: any(MiddlewareRequestType.self)).then { requestType in
                XCTAssertEqual(requestType, .transferMetadata)

                urlTemplateGetExpectation.fulfill()

                return Constants.transferMetadataUrlTemplate
            }

            when(stub).adapter(for: any(MiddlewareRequestType.self)).then { requestType in
                XCTAssertEqual(requestType, .transferMetadata)

                adapterExpectation.fulfill()

                return nil
            }

            when(stub).errorFactory(for: any(MiddlewareRequestType.self)).then { requestType in
                XCTAssertEqual(requestType, .transferMetadata)

                return errorFactory
            }
        }

        try TransferMetadataMock.register(mock: mock,
                                          networkResolver: networkResolver,
                                          requestType: .transferMetadata,
                                          httpMethod: .get,
                                          urlMockType: .regex)

        let assetsCount = 4
        let accountSettings = try createRandomAccountSettings(for: assetsCount)
        let operationSettings = try createRandomOperationSettings()
        let operationFactory = MiddlewareOperationFactory(accountSettings: accountSettings,
                                                          operationSettings: operationSettings,
                                                          networkResolver: networkResolver)
        let walletService = WalletService(operationFactory: operationFactory)

        let completionExpectation = XCTestExpectation()

        var result: Result<TransferMetaData?, Error>?

        walletService.fetchTransferMetadata(for: info, runCompletionIn: .main) { (optionalResult) in
            result = optionalResult
            completionExpectation.fulfill()
        }

        wait(for: [urlTemplateGetExpectation, adapterExpectation, completionExpectation],
             timeout: Constants.networkTimeout)

        return result
    }
}
