/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo

class ContactsServiceTests: NetworkBaseTests {

    func testSuccess() throws {
        let optionalResult = try performFetch(for: .success, errorFactory: nil)

        guard let result = optionalResult else {
            XCTFail("Unexpected nil result")
            return
        }

        if case .failure(let error) = result {
            XCTFail("Unexpected error \(error)")
        }
    }

    func testContactsWithDefaultErrorHandling() throws {
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

    func testContactsWithCustomErrorHandling() throws {
        let expectedError = MockNetworkError.contactsError
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

    private func performFetch(for mock: ContactsMock, errorFactory: MiddlewareNetworkErrorFactoryProtocol?) throws
        -> Result<[SearchData]?, Error>? {
        let networkResolver = MockMiddlewareNetworkResolverProtocol()

        let urlTemplateGetExpectation = XCTestExpectation()
        let adapterExpectation = XCTestExpectation()

        stub(networkResolver) { stub in
            when(stub).urlTemplate(for: any(MiddlewareRequestType.self)).then { requestType in
                XCTAssertEqual(requestType, .contacts)

                urlTemplateGetExpectation.fulfill()

                return Constants.contactsUrlTemplate
            }

            when(stub).adapter(for: any(MiddlewareRequestType.self)).then { requestType in
                XCTAssertEqual(requestType, .contacts)

                adapterExpectation.fulfill()

                return nil
            }

            when(stub).errorFactory(for: any(MiddlewareRequestType.self)).then { requestType in
                XCTAssertEqual(requestType, .contacts)

                return errorFactory
            }
        }

        try ContactsMock.register(mock: mock,
                                  networkResolver: networkResolver,
                                  requestType: .contacts,
                                  httpMethod: .get)

        let assetsCount = 4
        let accountSettings = try createRandomAccountSettings(for: assetsCount)
        let operationSettings = try createRandomOperationSettings()
        let operationFactory = MiddlewareOperationFactory(accountSettings: accountSettings,
                                                          operationSettings: operationSettings,
                                                          networkResolver: networkResolver)
        let walletService = WalletService(operationFactory: operationFactory)

        let contactsExpectation = XCTestExpectation()

        var result: Result<[SearchData]?, Error>?

        walletService.fetchContacts(runCompletionIn: .main) { optionalResult in
            result = optionalResult

            contactsExpectation.fulfill()
        }

        wait(for: [urlTemplateGetExpectation, adapterExpectation, contactsExpectation],
             timeout: Constants.networkTimeout)

        return result
    }
}
