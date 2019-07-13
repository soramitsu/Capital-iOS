/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo

class BalanceServiceTests: NetworkBaseTests {
    func testAccountBalanceSuccess() {
        do {
            // given
            let networkResolver = MockWalletNetworkResolverProtocol()

            let urlTemplateGetExpectation = XCTestExpectation()
            let adapterExpectation = XCTestExpectation()

            stub(networkResolver) { stub in
                when(stub).urlTemplate(for: any(WalletRequestType.self)).then { _ in
                    urlTemplateGetExpectation.fulfill()

                    return Constants.balanceUrlTemplate
                }

                when(stub).adapter(for: any(WalletRequestType.self)).then { _ in
                    adapterExpectation.fulfill()

                    return nil
                }
            }

            try FetchBalanceMock.register(mock: .success,
                                          networkResolver: networkResolver,
                                          requestType: .balance,
                                          mockMethod: .post)

            let assetsCount = 4
            let accountSettings = try createRandomAccountSettings(for: assetsCount)
            let operationFactory = WalletServiceOperationFactory(accountSettings: accountSettings)
            let walletService = WalletService(networkResolver: networkResolver,
                                              operationFactory: operationFactory)

            let balanceExpectation = XCTestExpectation()

            // when
            let assets = accountSettings.assets.map { $0.identifier }
            _ = walletService.fetchBalance(for: assets, runCompletionIn: .main) { (optionalResult) in
                defer {
                    balanceExpectation.fulfill()
                }

                guard let result = optionalResult else {
                    XCTFail("Unexpected nil result")
                    return
                }

                if case .error(let error) = result {
                    XCTFail("Unexpected error \(error)")
                }
            }

            // then

            wait(for: [urlTemplateGetExpectation, adapterExpectation, balanceExpectation],
                 timeout: Constants.networkTimeout)
        } catch {
            XCTFail("\(error)")
        }
    }
}
