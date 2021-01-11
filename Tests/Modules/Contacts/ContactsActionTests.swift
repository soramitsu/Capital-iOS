/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import XCTest
@testable import CommonWallet
import Cuckoo
import SoraFoundation

class ContactsScanPositionTests: NetworkBaseTests {

    func testBarActionAdded() throws {
        // given

        let view = MockContactsViewProtocol()

        let barViewModelExpectation = XCTestExpectation()
        let listViewModelExpectation = XCTestExpectation()

        let optionsCount = 5
        let withdrawOptions = (0..<optionsCount).map { _ in createRandomWithdrawOption() }

        stub(view) { stub in
            when(stub).set(barViewModel: any()).then { _ in
                barViewModelExpectation.fulfill()
            }

            when(stub).set(listViewModel: any()).then { viewModel in
                XCTAssertEqual(optionsCount, viewModel.contacts[0].items.count)

                listViewModelExpectation.fulfill()
            }

            when(stub).isSetup.get.thenReturn(false, true)
        }

        // when

        try performSetupForViewMock(view, scanPosition: .barButton, withdrawOptions: withdrawOptions)

        // then

        wait(for: [barViewModelExpectation, listViewModelExpectation], timeout: Constants.networkTimeout)
    }

    func testScanAsListActionAdded() throws {
        // given

        let view = MockContactsViewProtocol()

        let listViewModelExpectation = XCTestExpectation()

        let optionsCount = 5
        let withdrawOptions = (0..<optionsCount).map { _ in createRandomWithdrawOption() }

        stub(view) { stub in
            when(stub).set(listViewModel: any()).then { viewModel in
                XCTAssertEqual(optionsCount + 1, viewModel.contacts[0].items.count)

                listViewModelExpectation.fulfill()
            }

            when(stub).isSetup.get.thenReturn(false, true)
        }

        // when

        try performSetupForViewMock(view, scanPosition: .tableAction, withdrawOptions: withdrawOptions)

        // then

        wait(for: [listViewModelExpectation], timeout: Constants.networkTimeout)
    }

    func testNoScan() throws {
        // given

        let view = MockContactsViewProtocol()

        let listViewModelExpectation = XCTestExpectation()

        let optionsCount = 5
        let withdrawOptions = (0..<optionsCount).map { _ in createRandomWithdrawOption() }

        stub(view) { stub in
            when(stub).set(listViewModel: any()).then { viewModel in
                XCTAssertEqual(optionsCount, viewModel.contacts[0].items.count)

                listViewModelExpectation.fulfill()
            }

            when(stub).isSetup.get.thenReturn(false, true)
        }

        // when

        try performSetupForViewMock(view, scanPosition: .notInclude, withdrawOptions: withdrawOptions)

        // then

        wait(for: [listViewModelExpectation], timeout: Constants.networkTimeout)
    }

    func testActions() throws {
        // given

        let view = MockContactsViewProtocol()

        let listViewModelExpectation = XCTestExpectation()

        stub(view) { stub in
            when(stub).set(listViewModel: any()).then { viewModel in
                XCTAssertTrue(viewModel.contacts.isEmpty)

                listViewModelExpectation.fulfill()
            }

            when(stub).isSetup.get.thenReturn(false, true)
        }

        // when

        try performSetupForViewMock(view, scanPosition: .notInclude, withdrawOptions: [])

        // then

        wait(for: [listViewModelExpectation], timeout: Constants.networkTimeout)
    }

    // MARK: Private

    func performSetupForViewMock(_ view: MockContactsViewProtocol,
                                 scanPosition: WalletContactsScanPosition,
                                 withdrawOptions: [WalletWithdrawOption]) throws {
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

        let viewModelFactory = ContactsViewModelFactory(avatarRadius: 10.0,
                                                        nameIconStyle: contactsConfiguration.cellStyle.contactStyle.nameIcon)

        let actionViewModelFactory = ContactsActionViewModelFactory(scanPosition: scanPosition,
                                                                    withdrawOptions: withdrawOptions)

        let coordinator = MockContactsCoordinatorProtocol()

        try ContactsMock.register(mock: .success,
                                  networkResolver: networkResolver,
                                  requestType: .contacts,
                                  httpMethod: .get)

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
                                          localSearchEngine: nil,
                                          canFindItself: false)

        presenter.localizationManager = LocalizationManager(localization: WalletLanguage.english.rawValue)

        presenter.setup()
    }
}
