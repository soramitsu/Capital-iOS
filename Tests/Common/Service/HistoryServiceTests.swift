/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo
import IrohaCommunication

class HistoryServiceTests: NetworkBaseTests {

    func testHistorySuccess() {
        let transactionsPerPage: Int = 100
        let pagination = OffsetPagination(offset: 0, count: transactionsPerPage)
        performHistoryTest(for: .success,
                           pagination: pagination,
                           expectsError: false)
    }

    // MARK: Private

    private func performHistoryTest(for mock: FetchHistoryMock,
                                    pagination: OffsetPagination,
                                    expectsError: Bool) {
        do {
            // given
            let networkResolver = MockWalletNetworkResolverProtocol()

            let urlTemplateGetExpectation = XCTestExpectation()
            let adapterExpectation = XCTestExpectation()

            stub(networkResolver) { stub in
                when(stub).urlTemplate(for: any(WalletRequestType.self)).then { _ in
                    urlTemplateGetExpectation.fulfill()

                    return Constants.historyUrlTemplate
                }

                when(stub).adapter(for: any(WalletRequestType.self)).then { _ in
                    adapterExpectation.fulfill()

                    return nil
                }
            }

            try FetchHistoryMock.register(mock: mock,
                                          networkResolver: networkResolver,
                                          requestType: .history,
                                          mockMethod: .get,
                                          urlMockType: .regex)

            let assetsCount = 4
            let accountSettings = try createRandomAccountSettings(for: assetsCount)
            let operationFactory = WalletServiceOperationFactory(accountSettings: accountSettings)
            let walletService = WalletService(networkResolver: networkResolver,
                                              operationFactory: operationFactory)

            let historyExpectation = XCTestExpectation()

            // when

            let assets = accountSettings.assets.map { $0.identifier }
            _ = try walletService.fetchTransactionHistory(for: assets,
                                                          pagination: pagination,
                                                          runCompletionIn: .main) { (optionalResult) in
                defer {
                    historyExpectation.fulfill()
                }

                guard let result = optionalResult else {
                    XCTFail("Unexpected nil result")
                    return
                }

                switch result {
                case .success:
                    XCTAssert(!expectsError)
                case .error:
                    XCTAssert(expectsError)
                }
            }

            // then

            wait(for: [urlTemplateGetExpectation, adapterExpectation, historyExpectation],
                 timeout: Constants.networkTimeout)
        } catch {
            XCTFail("\(error)")
        }
    }
}
