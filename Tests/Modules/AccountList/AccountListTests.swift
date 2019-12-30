/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo
import SoraFoundation

class AccountListTests: NetworkBaseTests {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testInitialization() {
        do {
            let account = try createRandomAccountSettings(for: 4)

            let resolver = try createMockedResolver(for: account)

            XCTAssertNotNil(AccountListAssembly.assembleView(with: resolver))
        } catch {
            XCTFail("\(error)")
        }
    }

    func testSetupSuccess() {
        do {
            // given

            let account = try createRandomAccountSettings(for: 4)
            let resolver = try createMockedResolver(for: account)
            let networkResolver = MockNetworkResolver()

            let view = MockAccountListViewProtocol()
            let coordinator = MockAccountListCoordinatorProtocol()

            let eventCenter = MockWalletEventCenterProtocol()

            let presenter = try createPresenter(from: view,
                                                coordinator: coordinator,
                                                resolver: resolver,
                                                networkResolver: networkResolver,
                                                eventCenter: eventCenter)

            // when

            try FetchBalanceMock.register(mock: .success,
                                          networkResolver: networkResolver,
                                          requestType: .balance,
                                          httpMethod: .post)

            let reloadCompletionExpectation = XCTestExpectation()

            // immediatelly on setup, when cache is loaded, when new data received
            reloadCompletionExpectation.expectedFulfillmentCount = 3

            let newDataExpectation = XCTestExpectation()

            // immediatelly on setup, when new data received
            newDataExpectation.expectedFulfillmentCount = 2

            stub(view) { stub in
                when(stub).didLoad(viewModels: any(), collapsingRange: any()).then { _ in
                    newDataExpectation.fulfill()
                }

                when(stub).didCompleteReload().then {
                    reloadCompletionExpectation.fulfill()
                }

                when(stub).isSetup.get.thenReturn(false, true)
            }

            stub(eventCenter) { stub in
                stub.add(observer: any(), dispatchIn: any()).thenDoNothing()
                stub.remove(observer: any()).thenDoNothing()
            }

            presenter.localizationManager = LocalizationManager(localization: WalletLanguage.english.rawValue)

            // then

            presenter.setup()

            wait(for: [reloadCompletionExpectation, newDataExpectation], timeout: Constants.networkTimeout)

            verify(eventCenter, times(1)).add(observer: any(), dispatchIn: any())

        } catch {
            XCTFail("\(error)")
        }
    }

    func testSetupFail() {
        do {
            // given

            let account = try createRandomAccountSettings(for: 4)
            let resolver = try createMockedResolver(for: account)
            let networkResolver = MockNetworkResolver()

            let view = MockAccountListViewProtocol()
            let coordinator = MockAccountListCoordinatorProtocol()

            let eventCenter = MockWalletEventCenterProtocol()

            let presenter = try createPresenter(from: view,
                                                coordinator: coordinator,
                                                resolver: resolver,
                                                networkResolver: networkResolver,
                                                eventCenter: eventCenter)

            // when

            try FetchBalanceMock.register(mock: .error,
                                          networkResolver: networkResolver,
                                          requestType: .balance,
                                          httpMethod: .post)

            let reloadCompletionExpectation = XCTestExpectation()

            // immediatelly on setup, when cache is loaded, when new data loading fail
            reloadCompletionExpectation.expectedFulfillmentCount = 3

            let newDataExpectation = XCTestExpectation()

            // immediatelly on setup
            newDataExpectation.expectedFulfillmentCount = 1

            stub(view) { stub in
                when(stub).didLoad(viewModels: any(), collapsingRange: any()).then { _ in
                    newDataExpectation.fulfill()
                }

                when(stub).didCompleteReload().then {
                    reloadCompletionExpectation.fulfill()
                }

                when(stub).isSetup.get.thenReturn(false, true)
            }

            stub(eventCenter) { stub in
                stub.add(observer: any(), dispatchIn: any()).thenDoNothing()
                stub.remove(observer: any()).thenDoNothing()
            }

            presenter.localizationManager = LocalizationManager(localization: WalletLanguage.english.rawValue)

            // then

            presenter.setup()

            wait(for: [reloadCompletionExpectation, newDataExpectation], timeout: Constants.networkTimeout)

            verify(eventCenter, times(1)).add(observer: any(), dispatchIn: any())

        } catch {
            XCTFail("\(error)")
        }
    }

    // MARK: Private

    private func createPresenter(from view: AccountListViewProtocol,
                                 coordinator: AccountListCoordinatorProtocol,
                                 resolver: ResolverProtocol,
                                 networkResolver: WalletNetworkResolverProtocol,
                                 eventCenter: WalletEventCenterProtocol) throws -> AccountListPresenter {

        let networkOperationFactory = MiddlewareOperationFactory(accountSettings: resolver.account,
                                                                 networkResolver: networkResolver)

        let dataProviderFactory = DataProviderFactory(accountSettings: resolver.account,
                                                      cacheFacade: CoreDataTestCacheFacade(),
                                                      networkOperationFactory: networkOperationFactory)

        let balanceProvider = try dataProviderFactory.createBalanceDataProvider()

        let viewModelFactory = AccountModuleViewModelFactory(context: resolver.accountListConfiguration.viewModelContext,
                                                             assets: resolver.account.assets,
                                                             commandFactory: resolver.commandFactory,
                                                             commandDecoratorFactory: nil,
                                                             amountFormatter: NumberFormatter().localizableResource())

        return AccountListPresenter(view: view,
                                    coordinator: coordinator,
                                    balanceDataProvider: balanceProvider,
                                    viewModelFactory: viewModelFactory,
                                    eventCenter: eventCenter)
    }

    private func createMockedResolver(for account: WalletAccountSettingsProtocol) throws -> ResolverProtocol {
        let resolver = MockResolverProtocol()

        let networkOperationFactory = MockWalletNetworkOperationFactoryProtocol()
        let eventCenter = MockWalletEventCenterProtocol()

        let accountListConfiguration = try AccountListModuleBuilder().build()
        let style = WalletStyle()

        let commandFactory = createMockedCommandFactory()

        stub(resolver) { stub in
            when(stub).account.get.thenReturn(account)
            when(stub).networkOperationFactory.get.thenReturn(networkOperationFactory)
            when(stub).style.get.thenReturn(style)
            when(stub).accountListConfiguration.get.thenReturn(accountListConfiguration)
            when(stub).logger.get.thenReturn(nil)
            when(stub).commandFactory.get.thenReturn(commandFactory)
            when(stub).amountFormatter.get.thenReturn(NumberFormatter().localizableResource())
            when(stub).commandDecoratorFactory.get.thenReturn(nil)
            when(stub).eventCenter.get.thenReturn(eventCenter)
            when(stub).localizationManager.get.then {
                return LocalizationManager(localization: WalletLanguage.english.rawValue)
            }
        }

        return resolver
    }
}
