/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import XCTest
@testable import CommonWallet
import Cuckoo
import SoraFoundation

class ContactsLocalEngineTests: NetworkBaseTests {

    func testRemoteSearchAndThenTriggerLocalSearch() throws {
        // given

        let view = MockContactsViewProtocol()
        let localSearchEngine = MockContactsLocalSearchEngineProtocol()

        let presenter = try performSetupForViewMock(view, localSearchEngine: localSearchEngine)

        let remoteQuery = "Query"
        let localQuery = "Local query"

        let localResult = MockContactsLocalSearchResultProtocol()

        stub(localSearchEngine) { stub in
            when(stub).search(query: any(),
                              accountId: any(),
                              assetId: any(),
                              delegate: any(),
                              commandFactory: any()).then { (query, _, _, _, _) in
                if query == localQuery {
                    return [localResult]
                }

                return nil
            }
        }

        stub(view) { stub in
            when(stub).didStartSearch().thenDoNothing()
            when(stub).didStopSearch().thenDoNothing()
        }

        // when

        let remoteExpectation = XCTestExpectation()

        stub(view) { stub in
            when(stub).set(listViewModel: any()).then { viewModel in
                XCTAssertTrue(viewModel.found.first !== localResult)

                remoteExpectation.fulfill()
            }
        }

        presenter.search(remoteQuery)

        // then

        wait(for: [remoteExpectation], timeout: Constants.networkTimeout)

        // when

        let localExpectation = XCTestExpectation()

        stub(view) { stub in
            when(stub).set(listViewModel: any()).then { viewModel in
                XCTAssertTrue(viewModel.found.first === localResult)
                XCTAssertTrue(viewModel.found.count == 1)

                localExpectation.fulfill()
            }
        }

        presenter.search(remoteQuery)
        presenter.search(localQuery)

        // then

        wait(for: [localExpectation], timeout: Constants.networkTimeout)
    }

    // MARK: Private

    func performSetupForViewMock(_ view: MockContactsViewProtocol,
                                 localSearchEngine: ContactsLocalSearchEngineProtocol) throws -> ContactsPresenterProtocol {
        let accountSettings = try createRandomAccountSettings(for: 1)
        let operationSettings = try createRandomOperationSettings()
        let networkResolver = MockNetworkResolver()

        let cacheFacade = CoreDataTestCacheFacade()

        let networkOperationFactory = MiddlewareOperationFactory(accountSettings: accountSettings,
                                                                 operationSettings: operationSettings,
                                                                 networkResolver: networkResolver)

        let dataProviderFactory = DataProviderFactory(accountSettings: accountSettings,
                                                      cacheFacade: cacheFacade,
                                                      networkOperationFactory: networkOperationFactory,
                                                      identifierFactory: SingleProviderIdentifierFactory())
        let dataProvider = try dataProviderFactory.createContactsDataProvider()

        let walletService = WalletService(operationFactory: networkOperationFactory)

        let contactsConfiguration = ContactsModuleBuilder().build()

        let commandFactory = createMockedCommandFactory()

        let nameIconStyle = contactsConfiguration.cellStyle.contactStyle.nameIcon

        let viewModelFactory = ContactsViewModelFactory(avatarRadius: 10.0,
                                                        nameIconStyle: nameIconStyle)

        let actionViewModelFactory = ContactsActionViewModelFactory(scanPosition: .notInclude,
                                                                    withdrawOptions: [])

        let coordinator = MockContactsCoordinatorProtocol()

        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 3

        stub(view) { stub in
            when(stub).set(listViewModel: any(ContactListViewModelProtocol.self)).then { viewModel in
                expectation.fulfill()
            }

            when(stub).isSetup.get.thenReturn(false, true)
        }


        try ContactsMock.register(mock: .success,
                                  networkResolver: networkResolver,
                                  requestType: .contacts,
                                  httpMethod: .get)

        try SearchMock.register(mock: .success,
                                networkResolver: networkResolver,
                                requestType: .search,
                                httpMethod: .get,
                                urlMockType: .regex)

        let listViewModelFactory =
            ContactsListViewModelFactory(itemViewModelFactory: viewModelFactory,
                                         actionViewModelFactory: actionViewModelFactory)

        let presenter = ContactsPresenter(view: view,
                                          coordinator: coordinator,
                                          commandFactory: commandFactory,
                                          dataProvider: dataProvider,
                                          walletService: walletService,
                                          listViewModelFactory: listViewModelFactory,
                                          selectedAsset: accountSettings.assets[0],
                                          currentAccountId: accountSettings.accountId,
                                          localSearchEngine: localSearchEngine,
                                          canFindItself: false)

        presenter.localizationManager = LocalizationManager(localization: WalletLanguage.english.rawValue)

        presenter.setup()

        wait(for: [expectation], timeout: Constants.networkTimeout)

        return presenter
    }

}
