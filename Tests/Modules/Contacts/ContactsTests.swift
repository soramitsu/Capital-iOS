import XCTest
@testable import CommonWallet
import Cuckoo
import RobinHood


class ContactsTests: NetworkBaseTests {

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
            let dataProvider = try dataProviderFactory.createContactsDataProvider()

            let walletService = WalletService(networkResolver: networkResolver,
                                              operationFactory: networkOperationFactory)

            let contactsConfiguration = ContactsModuleBuilder().build()

            let viewModelFactory = ContactsViewModelFactory(configuration: contactsConfiguration, avatarRadius: 10.0)

            let view = MockContactsViewProtocol()
            let coordinator = MockContactsCoordinatorProtocol()

            // when

            let expectation = XCTestExpectation()
            expectation.expectedFulfillmentCount = 3

            stub(networkResolver) { stub in
                when(stub).urlTemplate(for: any(WalletRequestType.self)).then { _ in
                    return Constants.contactsUrlTemplate
                }

                when(stub).adapter(for: any(WalletRequestType.self)).then { _ in
                    return nil
                }
            }

            try ContactsMock.register(mock: .success,
                                      networkResolver: networkResolver,
                                      requestType: .contacts,
                                      httpMethod: .get)

            stub(view) { stub in
                when(stub).set(viewModel: any(ContactListViewModelProtocol.self)).then { viewModel in
                    expectation.fulfill()
                }
            }

            let presenter = ContactsPresenter(view: view,
                                              coordinator: coordinator,
                                              dataProvider: dataProvider,
                                              walletService: walletService,
                                              viewModelFactory: viewModelFactory,
                                              selectedAsset: accountSettings.assets[0],
                                              currentAccountId: accountSettings.accountId)

            presenter.setup()

            // then

            wait(for: [expectation], timeout: Constants.networkTimeout)

            XCTAssertTrue(presenter.viewModel.contacts.count > 0)

        } catch {
            XCTFail("\(error)")
        }
    }
}
