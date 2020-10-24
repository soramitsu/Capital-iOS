/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo
import RobinHood
import SoraFoundation

class HistoryTests: NetworkBaseTests {

    func testSetup() {
        [1, 2, 4].forEach { performTestSetup(assetsCount: $0) }
    }

    func testFilterAndThenReset() {
        [1, 2, 4].forEach { performTestFilterAndThenReset(assetsCount: $0) }
    }

    func testSetupAndThenDayChange() {
        do {
            // given

            let accountSettings = try createRandomAccountSettings(for: 4)
            let networkResolver = MockNetworkResolver()
            let view = MockHistoryViewProtocol()
            let coordinator = MockHistoryCoordinatorProtocol()

            let presenter = try performSetup(view: view,
                                             coordinator: coordinator,
                                             networkResolver: networkResolver,
                                             accountSettings: accountSettings)

            // when

            let expectation = XCTestExpectation()

            stub(view) { stub in
                when(stub).reloadContent().then {
                    XCTAssert(Thread.isMainThread)
                    expectation.fulfill()
                }
            }

            guard case .loaded = presenter.dataLoadingState else {
                XCTFail("Unexpected state \(presenter.dataLoadingState)")
                return
            }

            NotificationCenter.default.post(name: .NSCalendarDayChanged, object: self)

            // then

            wait(for: [expectation], timeout: Constants.networkTimeout)

            guard case .loaded = presenter.dataLoadingState else {
                XCTFail("Unexpected state \(presenter.dataLoadingState)")
                return
            }

        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }

    // MARK: Private

    private func performTestFilterAndThenReset(assetsCount: Int) {
        do {
            let accountSettings = try createRandomAccountSettings(for: assetsCount)
            let networkResolver = MockNetworkResolver()
            let view = MockHistoryViewProtocol()
            let coordinator = MockHistoryCoordinatorProtocol()

            let presenter = try performSetup(view: view,
                                             coordinator: coordinator,
                                             networkResolver: networkResolver,
                                             accountSettings: accountSettings)

            // filter

            var historyRequest = WalletHistoryRequest()
            historyRequest.type = UUID().uuidString

            performFilter(for: presenter,
                          view: view,
                          coordinator: coordinator,
                          resultFilterRequest: historyRequest)

            // reset filter

            performFilter(for: presenter,
                          view: view,
                          coordinator: coordinator,
                          resultFilterRequest: WalletHistoryRequest())

        } catch {
            XCTFail("\(error)")
        }
    }

    private func performTestSetup(assetsCount: Int) {
        do {
            let accountSettings = try createRandomAccountSettings(for: assetsCount)
            let networkResolver = MockNetworkResolver()
            let view = MockHistoryViewProtocol()
            let coordinator = MockHistoryCoordinatorProtocol()

            _ = try performSetup(view: view,
                                 coordinator: coordinator,
                                 networkResolver: networkResolver,
                                 accountSettings: accountSettings)

        } catch {
            XCTFail("\(error)")
        }
    }

    private func performFilter(for presenter: HistoryPresenter,
                               view: MockHistoryViewProtocol,
                               coordinator: MockHistoryCoordinatorProtocol,
                               resultFilterRequest: WalletHistoryRequest) {
        stub(coordinator) { stub in
            when(stub).presentFilter(filter: any(WalletHistoryRequest.self), assets: any([WalletAsset].self)).then { (filter, assets) in
                presenter.coordinator(coordinator, didReceive: resultFilterRequest)
            }
        }

        let filterCompletionExpectation = XCTestExpectation()

        stub(view) { stub in
            when(stub).handle(changes: any()).then { _ in
                filterCompletionExpectation.fulfill()
            }
        }

        presenter.showFilter()

        wait(for: [filterCompletionExpectation], timeout: Constants.networkTimeout)
    }

    private func performSetup(view: MockHistoryViewProtocol,
                              coordinator: MockHistoryCoordinatorProtocol,
                              networkResolver: MiddlewareNetworkResolverProtocol,
                              accountSettings: WalletAccountSettings) throws -> HistoryPresenter {
        // given

        let cacheFacade = CoreDataTestCacheFacade()

        let operationSettings = try createRandomOperationSettings()

        let networkOperationFactory = MiddlewareOperationFactory(accountSettings: accountSettings,
                                                                 operationSettings: operationSettings,
                                                                 networkResolver: networkResolver)

        let dataProviderFactory = DataProviderFactory(accountSettings: accountSettings,
                                                      cacheFacade: cacheFacade,
                                                      networkOperationFactory: networkOperationFactory,
                                                      identifierFactory: SingleProviderIdentifierFactory())

        let dataProvider = try dataProviderFactory.createHistoryDataProvider(for: accountSettings.assets.map( { $0.identifier }))

        let walletService = WalletService(operationFactory: networkOperationFactory)

        let dateFormatterProvider = DateFormatterProvider(dateFormatterFactory: TransactionListSectionFormatterFactory.self,
                                                          dayChangeHandler: DayChangeHandler())

        let commandFactory = createMockedCommandFactory()
        let itemViewModelFactory = HistoryItemViewModelFactory(amountFormatterFactory: NumberFormatterFactory(),
                                                               includesFeeInAmount: false,
                                                               transactionTypes: WalletTransactionType.required,
                                                               assets: accountSettings.assets)

        let viewModelFactory = HistoryViewModelFactory(dateFormatterProvider: dateFormatterProvider,
                                                       itemViewModelFactory: itemViewModelFactory,
                                                       commandFactory: commandFactory)

        let eventCenter = MockWalletEventCenterProtocol()

        // when

        try FetchHistoryMock.register(mock: .success,
                                      networkResolver: networkResolver,
                                      requestType: .history,
                                      httpMethod: .post,
                                      urlMockType: .regex)

        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 2

        stub(view) { stub in
            when(stub).reloadContent().then {
                expectation.fulfill()
            }

            when(stub).isSetup.get.thenReturn(false, true)
        }

        stub(eventCenter) { stub in
            stub.add(observer: any(), dispatchIn: any()).thenDoNothing()
            stub.remove(observer: any()).thenDoNothing()
        }

        let presenter = HistoryPresenter(view: view,
                                         coordinator: coordinator,
                                         dataProvider: dataProvider,
                                         walletService: walletService,
                                         eventCenter: eventCenter,
                                         viewModelFactory: viewModelFactory,
                                         assets: accountSettings.assets,
                                         transactionsPerPage: 100)

        presenter.localizationManager = LocalizationManager(localization: WalletLanguage.english.rawValue)

        presenter.setup()

        // then

        wait(for: [expectation], timeout: Constants.networkTimeout)

        verify(eventCenter, times(1)).add(observer: any(), dispatchIn: any())

        guard presenter.viewModels.count > 0 else {
            XCTFail("Must be single page")
            return presenter
        }

        guard presenter.viewModels[0].items.count > 0 else {
            XCTFail("Section must not be empty")
            return presenter
        }

        return presenter
    }
}
