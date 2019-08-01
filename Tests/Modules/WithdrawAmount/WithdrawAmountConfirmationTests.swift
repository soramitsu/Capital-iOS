/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import XCTest
@testable import CommonWallet
import IrohaCommunication
import Cuckoo

class WithdrawAmountConfirmationTests: NetworkBaseTests {

    func testSuccessfullAmountInput() {
        performConfirmationTest(for: "100", inputDescription: "", expectsSuccess: true)
        performConfirmationTest(for: "100", inputDescription: "Description", expectsSuccess: true)
    }

    func testUnsufficientFundsInput() {
        performConfirmationTest(for: "100000", inputDescription: "", expectsSuccess: false)
    }

    // MARK: Private

    private func performConfirmationTest(for inputAmount: String, inputDescription: String, expectsSuccess: Bool) {
        do {
            // given

            let assetId = try IRAssetIdFactory.asset(withIdentifier: Constants.soraAssetId)
            let walletAsset = WalletAsset(identifier: assetId, symbol: "A", details: UUID().uuidString)
            let withdrawOption = createRandomWithdrawOption()

            let accountSettings = try createRandomAccountSettings(for: [walletAsset],
                                                                  withdrawOptions: [withdrawOption])

            let selectedAsset = accountSettings.assets.first!
            let selectionOption = accountSettings.withdrawOptions.first!

            let networkResolver = MockWalletNetworkResolverProtocol()

            let cacheFacade = CoreDataTestCacheFacade()

            let networkOperationFactory = WalletServiceOperationFactory(accountSettings: accountSettings)

            let dataProviderFactory = DataProviderFactory(networkResolver: networkResolver,
                                                          accountSettings: accountSettings,
                                                          cacheFacade: cacheFacade,
                                                          networkOperationFactory: networkOperationFactory)

            let amountFormatter = NumberFormatter()
            let viewModelFactory = WithdrawAmountViewModelFactory(amountFormatter: amountFormatter,
                                                                  option: selectionOption,
                                                                  amountLimit: 1e+6,
                                                                  descriptionMaxLength: 64)

            let view = MockWithdrawAmountViewProtocol()
            let coordinator = MockWithdrawAmountCoordinatorProtocol()

            let assetViewModelObserver = MockAssetSelectionViewModelObserver()
            let feeViewModelObserver = MockWithdrawFeeViewModelObserver()

            // when

            stub(networkResolver) {stub in
                when(stub).urlTemplate(for: any(WalletRequestType.self)).then { type in
                    if type == .balance {
                        return Constants.balanceUrlTemplate
                    } else {
                        return Constants.withdrawalMetadataUrlTemplate
                    }
                }

                when(stub).adapter(for: any(WalletRequestType.self)).thenReturn(nil)
            }

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

            var assetSelectionViewModel: AssetSelectionViewModelProtocol?
            var feeViewModel: WithdrawFeeViewModelProtocol?
            var amountViewModel: AmountInputViewModelProtocol?
            var descriptionViewModel: DescriptionInputViewModelProtocol?

            stub(view) { stub in
                when(stub).set(title: any(String.self)).then { _ in
                    titleExpectation.fulfill()
                }

                when(stub).set(assetViewModel: any()).then { viewModel in
                    assetSelectionViewModel = viewModel
                    viewModel.observable.add(observer: assetViewModelObserver)

                    assetSelectionExpectation.fulfill()
                }

                when(stub).set(amountViewModel: any()).then { viewModel in
                    amountViewModel = viewModel

                    amountExpectation.fulfill()
                }

                when(stub).set(feeViewModel: any()).then { viewModel in
                    feeViewModel = viewModel
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
                    if feeViewModel?.isLoading == false {
                        feeLoadedExpectation.fulfill()
                    }
                }
            }

            let confirmExpectation = XCTestExpectation()

            stub(coordinator) { stub in
                when(stub).confirm(with: any(WithdrawInfo.self)).then { _ in
                    confirmExpectation.fulfill()
                }
            }

            let presenter = try WithdrawAmountPresenter(view: view,
                                                        coordinator: coordinator,
                                                        assets: accountSettings.assets,
                                                        selectedAsset: selectedAsset,
                                                        selectedOption: selectionOption,
                                                        dataProviderFactory: dataProviderFactory,
                                                        withdrawViewModelFactory: viewModelFactory,
                                                        assetTitleFactory: AssetSelectionFactory(amountFormatter: amountFormatter))

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

            assetSelectionViewModel?.observable.remove(observer: assetViewModelObserver)
            feeViewModel?.observable.remove(observer: feeViewModelObserver)

            XCTAssertNil(presenter.confirmationState)

            _ = amountViewModel?.didReceiveReplacement(inputAmount, for: NSRange(location: 0, length: 0))
            _ = descriptionViewModel?.didReceiveReplacement(description, for: NSRange(location: 0, length: 0))

            presenter.confirm()

            XCTAssertEqual(presenter.confirmationState, .waiting)

            if expectsSuccess {
                wait(for: [confirmExpectation], timeout: Constants.networkTimeout)
            } else {
                wait(for: [errorExpectation], timeout: Constants.networkTimeout)
            }

            XCTAssertNil(presenter.confirmationState)

        } catch {
            XCTFail("Did receive error \(error)")
        }
    }
}
