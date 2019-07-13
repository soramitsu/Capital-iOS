/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo
import RobinHood

class HistoryTests: NetworkBaseTests {

    func testSetup() {
        do {
            // given

            let accountSettings = try createRandomAccountSettings(for: 1)
            let networkResolver = MockWalletNetworkResolverProtocol()

            let cacheFacade = CoreDataTestCacheFacade()

            let networkOperationFactory = WalletServiceOperationFactory(accountSettings: accountSettings)

            let dataProviderFactory = DataProviderFactory(networkResolver: networkResolver,
                                                          accountSettings: accountSettings,
                                                          cacheFacade: cacheFacade,
                                                          networkOperationFactory: networkOperationFactory)
            let dataProvider = try dataProviderFactory.createAccountHistoryDataProvider()

            let walletService = WalletService(networkResolver: networkResolver,
                                              operationFactory: networkOperationFactory)

            let viewModelFactory = HistoryViewModelFactory(dateFormatter: DateFormatter.historyDateFormatter,
                                                           amountFormatter: NumberFormatter(),
                                                           assets: accountSettings.assets)

            let view = MockHistoryViewProtocol()
            let coordinator = MockHistoryCoordinatorProtocol()

            // when

            stub(networkResolver) { stub in
                when(stub).urlTemplate(for: any(WalletRequestType.self)).then { _ in
                    return Constants.historyUrlTemplate
                }

                when(stub).adapter(for: any(WalletRequestType.self)).then { _ in
                    return nil
                }
            }

            try FetchHistoryMock.register(mock: .success,
                                          networkResolver: networkResolver,
                                          requestType: .history,
                                          mockMethod: .get,
                                          urlMockType: .regex)

            let expectation = XCTestExpectation()
            expectation.expectedFulfillmentCount = 2

            stub(view) { stub in
                when(stub).didReload().then {
                    expectation.fulfill()
                }
            }

            let presenter = HistoryPresenter(view: view,
                                             coordinator: coordinator,
                                             dataProvider: dataProvider,
                                             walletService: walletService,
                                             viewModelFactory: viewModelFactory,
                                             assets: accountSettings.assets.map({ $0.identifier }),
                                             transactionsPerPage: 100)

            presenter.setup()

            // then

            wait(for: [expectation], timeout: Constants.networkTimeout)

            guard presenter.viewModels.count > 0 else {
                XCTFail("Must be single page")
                return
            }

            guard presenter.viewModels[0].items.count > 0 else {
                XCTFail("Section must not be empty")
                return
            }

        } catch {
            XCTFail("\(error)")
        }

    }
}
