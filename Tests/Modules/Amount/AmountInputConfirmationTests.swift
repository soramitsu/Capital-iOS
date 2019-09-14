/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo
import IrohaCommunication

class AmountInputConfirmationTests: NetworkBaseTests {

    func testSuccessfullAmountInput() {
        performConfirmationTest(for: "100", inputDescription: "", expectsSuccess: true)
        performConfirmationTest(for: "100", inputDescription: "Description", expectsSuccess: true)
    }

    func testUnsufficientFundsInput() {
        performConfirmationTest(for: "100000", inputDescription: "", expectsSuccess: false)
    }

    // MARK: Private

    func performConfirmationTest(for inputAmount: String, inputDescription: String, expectsSuccess: Bool) {
        do {
            // given

            let assetId = try IRAssetIdFactory.asset(withIdentifier: Constants.soraAssetId)
            let walletAsset = WalletAsset(identifier: assetId, symbol: "A", details: UUID().uuidString)
            let accountSettings = try createRandomAccountSettings(for: [walletAsset],
                                                                  withdrawOptions: [])

            let networkResolver = MockNetworkResolver()

            let cacheFacade = CoreDataTestCacheFacade()

            let networkOperationFactory = WalletServiceOperationFactory(accountSettings: accountSettings)

            let dataProviderFactory = DataProviderFactory(networkResolver: networkResolver,
                                                          accountSettings: accountSettings,
                                                          cacheFacade: cacheFacade,
                                                          networkOperationFactory: networkOperationFactory)
            let dataProvider = try dataProviderFactory.createBalanceDataProvider()

            let assetSelectionFactory = AssetSelectionFactory(amountFormatter: NumberFormatter())
            let accessoryViewModelFactory = ContactAccessoryViewModelFactory(style: WalletStyle().nameIconStyle,
                                                                             radius: AccessoryView.iconRadius)

            let view = MockAmountViewProtocol()
            let coordinator = MockAmountCoordinatorProtocol()

            let assetSelectionObserver = MockAssetSelectionViewModelObserver()

            // when

            let assetExpectation = XCTestExpectation()
            let amountExpectation = XCTestExpectation()
            let descriptionExpectation = XCTestExpectation()
            let accessoryExpectation = XCTestExpectation()

            let balanceExpectation = XCTestExpectation()

            let completionExpectation = XCTestExpectation()

            var amountViewModel: AmountInputViewModelProtocol?
            var descriptionViewModel: DescriptionInputViewModelProtocol?

            stub(view) { stub in
                when(stub).set(assetViewModel: any()).then { assetViewModel in
                    assetViewModel.observable.add(observer: assetSelectionObserver)
                    assetExpectation.fulfill()
                }

                when(stub).set(amountViewModel: any()).then { viewModel in
                    amountViewModel = viewModel

                    amountExpectation.fulfill()
                }

                when(stub).set(descriptionViewModel: any()).then { viewModel in
                    descriptionViewModel = viewModel

                    descriptionExpectation.fulfill()
                }

                when(stub).set(accessoryViewModel: any()).then { _ in
                    accessoryExpectation.fulfill()
                }

                when(stub).showAlert(title: any(), message: any(), actions: any(), completion: any()).then { _ in
                    completionExpectation.fulfill()
                }

                when(stub).didStartLoading().thenDoNothing()
                when(stub).didStopLoading().thenDoNothing()

                when(stub).controller.get.thenReturn(UIViewController())
            }

            stub(coordinator) { stub in
                when(stub).confirm(with: any(TransferPayload.self)).then { _ in
                    completionExpectation.fulfill()
                }
            }

            stub(assetSelectionObserver) { stub in
                when(stub).assetSelectionDidChangeTitle().then { title in
                    balanceExpectation.fulfill()
                }
            }

            try FetchBalanceMock.register(mock: .success,
                                          networkResolver: networkResolver,
                                          requestType: .balance,
                                          httpMethod: .post)

            let recieverInfo = try createRandomReceiveInfo()
            let amountPayload = AmountPayload(receiveInfo: recieverInfo, receiverName: UUID().uuidString)

            let presenter = AmountPresenter(view: view,
                                            coordinator: coordinator,
                                            balanceDataProvider: dataProvider,
                                            account: accountSettings,
                                            payload: amountPayload,
                                            assetSelectionFactory: assetSelectionFactory,
                                            accessoryFactory: accessoryViewModelFactory,
                                            amountLimit: 1e+6,
                                            descriptionMaxLength: 64)

            presenter.setup()

            wait(for: [assetExpectation, amountExpectation, descriptionExpectation, balanceExpectation, accessoryExpectation], timeout: Constants.networkTimeout)

            // then

            guard let currentAmountViewModel = amountViewModel else {
                XCTFail("Unexpected empty amount view model")
                return
            }

            guard let currentDescriptionViewModel = descriptionViewModel else {
                XCTFail("Unexpected empty description view model")
                return
            }

            _ = currentAmountViewModel.didReceiveReplacement(inputAmount,
                                                             for: NSRange(location: 0, length: 0))
            _ = currentDescriptionViewModel.didReceiveReplacement(inputDescription,
                                                                  for: NSRange(location: 0, length: 0))

            presenter.confirm()

            wait(for: [completionExpectation], timeout: Constants.networkTimeout)

            if expectsSuccess {
                verify(coordinator, times(1)).confirm(with: any(TransferPayload.self))
            } else {
                verify(view, times(1)).showAlert(title: any(), message: any(),
                                                        actions: any(), completion: any())
            }

        } catch {
            XCTFail("\(error)")
        }
    }
}
