/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo

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

            let view = MockAccountListViewProtocol()
            let coordinator = MockAccountListCoordinatorProtocol()

            let presenter = try createPresenter(from: view, coordinator: coordinator, resolver: resolver)

            // when

            try FetchBalanceMock.register(mock: .success,
                                          networkResolver: resolver.networkResolver,
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
            }

            // then

            presenter.setup()

            wait(for: [reloadCompletionExpectation, newDataExpectation], timeout: Constants.networkTimeout)

        } catch {
            XCTFail("\(error)")
        }
    }

    func testSetupFail() {
        do {
            // given

            let account = try createRandomAccountSettings(for: 4)
            let resolver = try createMockedResolver(for: account)

            let view = MockAccountListViewProtocol()
            let coordinator = MockAccountListCoordinatorProtocol()

            let presenter = try createPresenter(from: view, coordinator: coordinator, resolver: resolver)

            // when

            try FetchBalanceMock.register(mock: .error,
                                          networkResolver: resolver.networkResolver,
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
            }

            // then

            presenter.setup()

            wait(for: [reloadCompletionExpectation, newDataExpectation], timeout: Constants.networkTimeout)

        } catch {
            XCTFail("\(error)")
        }
    }

    // MARK: Private

    private func createPresenter(from view: AccountListViewProtocol,
                                 coordinator: AccountListCoordinatorProtocol,
                                 resolver: ResolverProtocol) throws -> AccountListPresenter {

        let networkOperationFactory = WalletServiceOperationFactory(accountSettings: resolver.account)

        let dataProviderFactory = DataProviderFactory(networkResolver: resolver.networkResolver,
                                                      accountSettings: resolver.account,
                                                      cacheFacade: CoreDataTestCacheFacade(),
                                                      networkOperationFactory: networkOperationFactory)

        let balanceProvider = try dataProviderFactory.createBalanceDataProvider()

        let viewModelFactory = AccountModuleViewModelFactory(context: resolver.accountListConfiguration.viewModelContext,
                                                             assets: resolver.account.assets)

        return AccountListPresenter(view: view,
                                    coordinator: coordinator,
                                    balanceDataProvider: balanceProvider,
                                    viewModelFactory: viewModelFactory)
    }

    private func createMockedResolver(for account: WalletAccountSettingsProtocol) throws -> ResolverProtocol {
        let resolver = MockResolverProtocol()

        let networkResolver = MockWalletNetworkResolverProtocol()

        stub(networkResolver) { stub in
            when(stub).urlTemplate(for: any(WalletRequestType.self)).then { _ in
                return Constants.balanceUrlTemplate
            }

            when(stub).adapter(for: any(WalletRequestType.self)).then { _ in
                return nil
            }
        }

        let accountListConfiguration = try AccountListModuleBuilder().build()
        let style = WalletStyle()

        stub(resolver) { stub in
            when(stub).account.get.then { account }
            when(stub).networkResolver.get.then { networkResolver }
            when(stub).style.get.then { style }
            when(stub).accountListConfiguration.get.then { accountListConfiguration }
            when(stub).logger.get.then { nil }
        }

        return resolver
    }
}
