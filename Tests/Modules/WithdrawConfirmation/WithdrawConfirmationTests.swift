import XCTest
@testable import CommonWallet
import Cuckoo

class WithdrawConfirmationTests: NetworkBaseTests {

    func testSetupAndConfirm() {
        do {
            // given

            let accountSettings = try createRandomAccountSettings(for: 1, withdrawOptionsCount: 1)
            let networkResolver = MockWalletNetworkResolverProtocol()

            let networkOperationFactory = WalletServiceOperationFactory(accountSettings: accountSettings)

            let view = MockWalletFormViewProtocol()
            let coordinator = MockWithdrawConfirmationCoordinatorProtocol()

            let walletService = WalletService(networkResolver: networkResolver,
                                              operationFactory: networkOperationFactory)

            let withdrawInfo = try createRandomWithdrawInfo()

            let presenter = WithdrawConfirmationPresenter(view: view,
                                                          coordinator: coordinator,
                                                          walletService: walletService,
                                                          withdrawInfo: withdrawInfo,
                                                          asset: accountSettings.assets[0],
                                                          withdrawOption: accountSettings.withdrawOptions[0],
                                                          style: WalletStyle(),
                                                          amountFormatter: NumberFormatter())

            // when

            let setupExpectation = XCTestExpectation()
            let confirmExpectation = XCTestExpectation()

            stub(view) { stub in
                when(stub).didReceive(viewModels: any([WalletFormViewModelProtocol].self)).then { _ in
                    setupExpectation.fulfill()
                }

                when(stub).didReceive(accessoryViewModel: any(AccessoryViewModelProtocol.self)).thenDoNothing()

                when(stub).didStartLoading().thenDoNothing()
                when(stub).didStopLoading().thenDoNothing()
            }

            stub(coordinator) { stub in
                when(stub).showResult(for: any(WithdrawInfo.self),
                                      asset: any(WalletAsset.self),
                                      option: any(WalletWithdrawOption.self)).then { _ in
                    confirmExpectation.fulfill()
                }
            }

            stub(networkResolver) { stub in
                when(stub).urlTemplate(for: any(WalletRequestType.self)).thenReturn(Constants.withdrawUrlTemplate)
                when(stub).adapter(for: any(WalletRequestType.self)).thenReturn(nil)
            }

            try WithdrawMock.register(mock: .success,
                                      networkResolver: networkResolver,
                                      requestType: .withdraw,
                                      httpMethod: .post)

            presenter.setup()

            // then

            wait(for: [setupExpectation], timeout: Constants.networkTimeout)

            // when

            presenter.performAction()

            // then

            wait(for: [confirmExpectation], timeout: Constants.networkTimeout)

        } catch {
            XCTFail("\(error)")
        }
    }
}
