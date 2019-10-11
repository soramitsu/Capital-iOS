/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import XCTest
@testable import CommonWallet
import Cuckoo

class WithdrawalMetadataServiceTests: NetworkBaseTests {

    func testWithdrawalMetadataSuccess() {
        do {
            // given
            let networkResolver = MockWalletNetworkResolverProtocol()

            let urlTemplateGetExpectation = XCTestExpectation()
            let adapterExpectation = XCTestExpectation()

            stub(networkResolver) { stub in
                when(stub).urlTemplate(for: any(WalletRequestType.self)).then { _ in
                    urlTemplateGetExpectation.fulfill()

                    return Constants.withdrawalMetadataUrlTemplate
                }

                when(stub).adapter(for: any(WalletRequestType.self)).then { _ in
                    adapterExpectation.fulfill()

                    return nil
                }
            }

            try WithdrawalMetadataMock.register(mock: .success,
                                                networkResolver: networkResolver,
                                                requestType: .withdrawalMetadata,
                                                httpMethod: .get,
                                                urlMockType: .regex)

            let assetsCount = 4
            let accountSettings = try createRandomAccountSettings(for: assetsCount)
            let operationFactory = WalletNetworkOperationFactory(accountSettings: accountSettings)
            let walletService = WalletService(networkResolver: networkResolver,
                                              operationFactory: operationFactory)

            let completionExpectation = XCTestExpectation()

            // when

            let info = try createRandomWithdrawMetadataInfo()
            walletService.fetchWithdrawalMetadata(for: info, runCompletionIn: .main) { (optionalResult) in
                defer {
                    completionExpectation.fulfill()
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

            wait(for: [urlTemplateGetExpectation, adapterExpectation, completionExpectation],
                 timeout: Constants.networkTimeout)
        } catch {
            XCTFail("\(error)")
        }
    }

}
