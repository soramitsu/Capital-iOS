/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo

class SearchServiceTests: NetworkBaseTests {

    func testSearchSuccess() {
        performSearchTestSuccess(query: UUID().uuidString)
        performSearchTestSuccess(query: "Поищи")
        performSearchTestSuccess(query: "サーチ")
    }

    // MARK: Private

    private func performSearchTestSuccess(query: String) {
        do {
            // given
            let networkResolver = MockWalletNetworkResolverProtocol()

            let urlTemplateGetExpectation = XCTestExpectation()
            let adapterExpectation = XCTestExpectation()

            stub(networkResolver) { stub in
                when(stub).urlTemplate(for: any(WalletRequestType.self)).then { _ in
                    urlTemplateGetExpectation.fulfill()

                    return Constants.searchUrlTemplate
                }

                when(stub).adapter(for: any(WalletRequestType.self)).then { _ in
                    adapterExpectation.fulfill()

                    return nil
                }
            }

            try SearchMock.register(mock: .success,
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

            // when

            walletService.search(for: query, runCompletionIn: .main) { (optionalResult) in
                defer {
                    searchExpectation.fulfill()
                }

                guard let result = optionalResult else {
                    XCTFail("Unexpected nil result")
                    return
                }

                if case .failure(let error) = result {
                    XCTFail("Unexpected error \(error)")
                }
            }

            // then

            wait(for: [urlTemplateGetExpectation, adapterExpectation, searchExpectation],
                 timeout: Constants.networkTimeout)
        } catch {
            XCTFail("\(error)")
        }
    }
}
