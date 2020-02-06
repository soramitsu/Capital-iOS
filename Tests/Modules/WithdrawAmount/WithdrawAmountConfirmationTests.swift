/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import XCTest
@testable import CommonWallet
import IrohaCommunication
import Cuckoo
import SoraFoundation

class WithdrawAmountConfirmationTests: NetworkBaseTests {

    func testSuccessfullAmountInput() {
        let networkResolver = MockNetworkResolver()
        performConfirmationTest(for: networkResolver, inputAmount: "100", inputDescription: "", expectsSuccess: true)
        performConfirmationTest(for: networkResolver, inputAmount: "100", inputDescription: "Description", expectsSuccess: true)
    }

    func testUnsufficientFundsInput() {
        let networkResolver = MockNetworkResolver()
        performConfirmationTest(for: networkResolver, inputAmount: "100000", inputDescription: "", expectsSuccess: false)
    }

    func testFeeNotAvailable() {
        let networkResolver = MockNetworkResolver()
        performConfirmationTest(for: networkResolver, inputAmount: "100", inputDescription: "", expectsSuccess: false) {
            try? WithdrawalMetadataMock.register(mock: .notAvailable,
                                                networkResolver: networkResolver,
                                                requestType: .withdrawalMetadata,
                                                httpMethod: .get,
                                                urlMockType: .regex)
        }
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
            let withdrawOption = createRandomWithdrawOption()

            let accountSettings = try createRandomAccountSettings(for: [walletAsset],
                                                                  withdrawOptions: [withdrawOption])

            let selectedAsset = accountSettings.assets.first!
            let selectionOption = accountSettings.withdrawOptions.first!

            let cacheFacade = CoreDataTestCacheFacade()

            let networkOperationFactory = MiddlewareOperationFactory(accountSettings: accountSettings,
                                                                     networkResolver: networkResolver)

            let dataProviderFactory = DataProviderFactory(accountSettings: accountSettings,
                                                          cacheFacade: cacheFacade,
                                                          networkOperationFactory: networkOperationFactory)

            let inputValidatorFactory = WalletInputValidatorFactoryDecorator(descriptionMaxLength: 64)
            let viewModelFactory = WithdrawAmountViewModelFactory(amountFormatterFactory: NumberFormatterFactory(),
                                                                  option: selectionOption,
                                                                  amountLimit: 1e+6,
                                                                  descriptionValidatorFactory: inputValidatorFactory)

            let view = MockWithdrawAmountViewProtocol()
            let coordinator = MockWithdrawAmountCoordinatorProtocol()

            let assetViewModelObserver = MockAssetSelectionViewModelObserver()
            let feeViewModelObserver = MockFeeViewModelObserver()

            // when

            try FetchBalanceMock.register(mock: .success,
                                          networkResolver: networkResolver,
                                          requestType: .balance,
                                          httpMethod: .post)

            try WithdrawalMetadataMock.register(mock: .success,
                                                networkResolver: networkResolver,
                                                requestType: .withdrawalMetadata,
                                                httpMethod: .get,
                                                urlMockType: .regex)

            let titleExpectation = XCTestExpectation()
            let assetSelectionExpectation = XCTestExpectation()
            let amountExpectation = XCTestExpectation()
            let feeExpectation = XCTestExpectation()
            let descriptionExpectation = XCTestExpectation()
            let accessoryExpectation = XCTestExpectation()
            let errorExpectation = XCTestExpectation()
            let balanceLoadedExpectation = XCTestExpectation()
            
            let feeLoadedExpectation = XCTestExpectation()
            feeLoadedExpectation.expectedFulfillmentCount = 2

            var amountViewModel: AmountInputViewModelProtocol?
            var descriptionViewModel: DescriptionInputViewModelProtocol?

            stub(view) { stub in
                when(stub).set(title: any(String.self)).then { _ in
                    titleExpectation.fulfill()
                }

                when(stub).set(assetViewModel: any()).then { viewModel in
                    viewModel.observable.add(observer: assetViewModelObserver)

                    assetSelectionExpectation.fulfill()
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

                when(stub).didChange(accessoryViewModel: any()).then { _ in
                    accessoryExpectation.fulfill()
                }

                when(stub).showAlert(title: any(), message: any(), actions: any(), completion: any()).then { _ in
                    errorExpectation.fulfill()
                }

                when(stub).isSetup.get.thenReturn(false, true)

                when(stub).didStartLoading().thenDoNothing()
                when(stub).didStopLoading().thenDoNothing()
            }

            stub(assetViewModelObserver) { stub in
                when(stub).assetSelectionDidChangeTitle().then {
                    balanceLoadedExpectation.fulfill()
                }
            }

            stub(feeViewModelObserver) { stub in
                when(stub).feeTitleDidChange().thenDoNothing()

                when(stub).feeLoadingStateDidChange().then {
                    feeLoadedExpectation.fulfill()
                }
            }

            let confirmExpectation = XCTestExpectation()

            var infoToConfirm: WithdrawInfo?

            stub(coordinator) { stub in
                when(stub).confirm(with: any(WithdrawInfo.self),
                                   asset: any(WalletAsset.self),
                                   option: any(WalletWithdrawOption.self)).then { info, asset, option in
                                    infoToConfirm = info
                                    confirmExpectation.fulfill()
                }
            }

            let assetSelectionFactory = AssetSelectionFactory(amountFormatterFactory: NumberFormatterFactory())

            let presenter = try WithdrawAmountPresenter(view: view,
                                                        coordinator: coordinator,
                                                        assets: accountSettings.assets,
                                                        selectedAsset: selectedAsset,
                                                        selectedOption: selectionOption,
                                                        dataProviderFactory: dataProviderFactory,
                                                        feeCalculationFactory: FeeCalculationFactory(),
                                                        withdrawViewModelFactory: viewModelFactory,
                                                        assetTitleFactory: assetSelectionFactory,
                                                        localizationManager: LocalizationManager(localization: WalletLanguage.english.rawValue))

            // then

            presenter.setup()

            wait(for: [titleExpectation,
                       assetSelectionExpectation,
                       amountExpectation,
                       feeExpectation,
                       descriptionExpectation,
                       accessoryExpectation,
                       balanceLoadedExpectation,
                       feeLoadedExpectation], timeout: Constants.networkTimeout)

            XCTAssertNil(presenter.confirmationState)

            _ = amountViewModel?.didReceiveReplacement(inputAmount, for: NSRange(location: 0, length: 0))
            _ = descriptionViewModel?.didReceiveReplacement(description, for: NSRange(location: 0, length: 0))

            beforeConfirmationBlock?()

            presenter.confirm()

            XCTAssertEqual(presenter.confirmationState, .waiting)

            if expectsSuccess {
                wait(for: [confirmExpectation], timeout: Constants.networkTimeout)
                
                XCTAssertEqual(infoToConfirm?.amount.value, inputAmount)
            } else {
                wait(for: [errorExpectation], timeout: Constants.networkTimeout)
            }

            XCTAssertNil(presenter.confirmationState)

        } catch {
            XCTFail("Did receive error \(error)")
        }
    }
}
