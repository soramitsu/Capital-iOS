/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo
import IrohaCommunication
import SoraFoundation

class AmountInputConfirmationTests: NetworkBaseTests {

    func testSuccessfullAmountInput() {
        let networkResolver = MockNetworkResolver()
        performConfirmationTest(for: networkResolver, inputAmount: "100", inputDescription: "", expectsSuccess: true)
        performConfirmationTest(for: networkResolver, inputAmount: "100", inputDescription: "Description", expectsSuccess: true)
    }

    func testUnsufficientFundsInput() {
        let networkResolver = MockNetworkResolver()
        performConfirmationTest(for: networkResolver, inputAmount: "100000", inputDescription: "", expectsSuccess: false)
    }

    // MARK: Private

    private func performConfirmationTest(for networkResolver: WalletNetworkResolverProtocol,
                                         inputAmount: String,
                                         inputDescription: String,
                                         expectsSuccess: Bool,
                                         beforeConfirmationBlock: (() -> Void)? = nil) {
        do {
            // given

            let assetId = try IRAssetIdFactory.asset(withIdentifier: Constants.soraAssetId)
            let walletAsset = WalletAsset(identifier: assetId,
                                          symbol: "A",
                                          details: LocalizableResource { _ in UUID().uuidString },
                                          precision: 2)
            let accountSettings = try createRandomAccountSettings(for: [walletAsset],
                                                                  withdrawOptions: [])

            let cacheFacade = CoreDataTestCacheFacade()

            let networkOperationFactory = MiddlewareOperationFactory(accountSettings: accountSettings,
                                                                     networkResolver: networkResolver)

            let dataProviderFactory = DataProviderFactory(accountSettings: accountSettings,
                                                          cacheFacade: cacheFacade,
                                                          networkOperationFactory: networkOperationFactory)

            let assetSelectionFactory = AssetSelectionFactory(amountFormatterFactory: NumberFormatterFactory())
            let accessoryViewModelFactory = ContactAccessoryViewModelFactory(style: WalletStyle().nameIconStyle,
                                                                             radius: AccessoryView.iconRadius)

            let view = MockAmountViewProtocol()
            let coordinator = MockAmountCoordinatorProtocol()

            let assetSelectionObserver = MockAssetSelectionViewModelObserver()
            let feeViewModelObserver = MockFeeViewModelObserver()

            try FetchBalanceMock.register(mock: .success,
                                          networkResolver: networkResolver,
                                          requestType: .balance,
                                          httpMethod: .post)

            try TransferMetadataMock.register(mock: .success,
                                              networkResolver: networkResolver,
                                              requestType: .transferMetadata,
                                              httpMethod: .get,
                                              urlMockType: .regex)

            // when

            let assetExpectation = XCTestExpectation()
            let amountExpectation = XCTestExpectation()
            let feeExpectation = XCTestExpectation()
            let descriptionExpectation = XCTestExpectation()
            let errorExpectation = XCTestExpectation()
            let accessoryExpectation = XCTestExpectation()

            let balanceExpectation = XCTestExpectation()
            let feeLoadedExpectation = XCTestExpectation()
            feeLoadedExpectation.expectedFulfillmentCount = 2

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

                when(stub).set(feeViewModel: any()).then { viewModel in
                    viewModel.observable.add(observer: feeViewModelObserver)

                    feeExpectation.fulfill()
                }

                when(stub).set(descriptionViewModel: any()).then { viewModel in
                    descriptionViewModel = viewModel

                    descriptionExpectation.fulfill()
                }

                when(stub).set(accessoryViewModel: any()).then { _ in
                    accessoryExpectation.fulfill()
                }

                when(stub).showAlert(title: any(), message: any(), actions: any(), completion: any()).then { _ in
                    errorExpectation.fulfill()
                }

                when(stub).didStartLoading().thenDoNothing()
                when(stub).didStopLoading().thenDoNothing()

                when(stub).controller.get.thenReturn(UIViewController())

                when(stub).isSetup.get.thenReturn(false, true)
            }

            stub(assetSelectionObserver) { stub in
                when(stub).assetSelectionDidChangeTitle().then { title in
                    balanceExpectation.fulfill()
                }
            }

            stub(feeViewModelObserver) { stub in
                when(stub).feeTitleDidChange().thenDoNothing()

                when(stub).feeLoadingStateDidChange().then {
                    feeLoadedExpectation.fulfill()
                }
            }

            let confirmExpectation = XCTestExpectation()

            var payloadToConfirm: TransferPayload?

            stub(coordinator) { stub in
                when(stub).confirm(with: any(TransferPayload.self)).then { payload in
                    payloadToConfirm = payload

                    confirmExpectation.fulfill()
                }
            }

            var recieverInfo = try createRandomReceiveInfo()
            recieverInfo.amount = nil

            let amountPayload = AmountPayload(receiveInfo: recieverInfo, receiverName: UUID().uuidString)

            let inputValidatorFactory = WalletInputValidatorFactoryDecorator(descriptionMaxLength: 64)
            let transferViewModelFactory = AmountViewModelFactory(amountFormatterFactory: NumberFormatterFactory(),
                                                                  amountLimit: 1e+6,
                                                                  descriptionValidatorFactory: inputValidatorFactory)

            let presenter = try AmountPresenter(view: view,
                                                coordinator: coordinator,
                                                payload: amountPayload,
                                                dataProviderFactory: dataProviderFactory,
                                                feeCalculationFactory: FeeCalculationFactory(),
                                                account: accountSettings,
                                                transferViewModelFactory: transferViewModelFactory,
                                                assetSelectionFactory: assetSelectionFactory,
                                                accessoryFactory: accessoryViewModelFactory,
                                                localizationManager: LocalizationManager(localization: WalletLanguage.english.rawValue))

            presenter.setup()

            wait(for: [assetExpectation,
                       amountExpectation,
                       feeExpectation,
                       descriptionExpectation,
                       balanceExpectation,
                       accessoryExpectation,
                       feeLoadedExpectation],
                 timeout: Constants.networkTimeout)

            // then

            XCTAssertNil(presenter.confirmationState)

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

            beforeConfirmationBlock?()

            presenter.confirm()

            XCTAssertEqual(presenter.confirmationState, .waiting)

            if expectsSuccess {
                wait(for: [confirmExpectation], timeout: Constants.networkTimeout)

                XCTAssertEqual(payloadToConfirm?.transferInfo.amount.value, inputAmount)
            } else {
                wait(for: [errorExpectation], timeout: Constants.networkTimeout)
            }

            XCTAssertNil(presenter.confirmationState)

        } catch {
            XCTFail("\(error)")
        }
    }
}
