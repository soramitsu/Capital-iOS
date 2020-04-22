/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import XCTest
@testable import CommonWallet
import Cuckoo
import SoraFoundation


class WithdrawAmountSetupTests: NetworkBaseTests {

    func testPerformSuccessfullSetup() {
        do {
            let networkResolver = MockNetworkResolver()

            try FetchBalanceMock.register(mock: .success,
                                          networkResolver: networkResolver,
                                          requestType: .balance,
                                          httpMethod: .post)

            try WithdrawalMetadataMock.register(mock: .success,
                                                networkResolver: networkResolver,
                                                requestType: .withdrawalMetadata,
                                                httpMethod: .get,
                                                urlMockType: .regex)

            try performTestSetup(for: networkResolver, expectsFeeFailure: false)
        } catch {
            XCTFail("Did receive error \(error)")
        }
    }

    func testFeeFailureHandling() {
        do {
            let networkResolver = MockNetworkResolver()

            try FetchBalanceMock.register(mock: .success,
                                          networkResolver: networkResolver,
                                          requestType: .balance,
                                          httpMethod: .post)

            try WithdrawalMetadataMock.register(mock: .notAvailable,
                                                networkResolver: networkResolver,
                                                requestType: .withdrawalMetadata,
                                                httpMethod: .get,
                                                urlMockType: .regex)

            try performTestSetup(for: networkResolver, expectsFeeFailure: true)
        } catch {
            XCTFail("Did receive error \(error)")
        }
    }

    // MARK: Private

    private func performTestSetup(for networkResolver: MiddlewareNetworkResolverProtocol, expectsFeeFailure: Bool) throws {
        // given

        let walletAsset = WalletAsset(identifier: Constants.soraAssetId,
                                      symbol: "A",
                                      details: LocalizableResource { _ in UUID().uuidString },
                                      precision: 2)
        let withdrawOption = createRandomWithdrawOption()

        let accountSettings = try createRandomAccountSettings(for: [walletAsset],
                                                              withdrawOptions: [withdrawOption])

        let cacheFacade = CoreDataTestCacheFacade()

        let operationSettings = try createRandomOperationSettings()

        let networkOperationFactory = MiddlewareOperationFactory(accountSettings: accountSettings,
                                                                 operationSettings: operationSettings,
                                                                 networkResolver: networkResolver)

        let dataProviderFactory = DataProviderFactory(accountSettings: accountSettings,
                                                      cacheFacade: cacheFacade,
                                                      networkOperationFactory: networkOperationFactory)

        let inputValidatorFactory = WalletInputValidatorFactoryDecorator(descriptionMaxLength: 64)
        let viewModelFactory = WithdrawAmountViewModelFactory(amountFormatterFactory: NumberFormatterFactory(),
                                                              option: withdrawOption,
                                                              descriptionValidatorFactory: inputValidatorFactory,
                                                              transactionSettingsFactory: WalletTransactionSettingsFactory(),
                                                              feeDisplaySettingsFactory: FeeDisplaySettingsFactory())

        let view = MockAmountViewProtocol()
        let coordinator = MockWithdrawAmountCoordinatorProtocol()

        let assetViewModelObserver = MockAssetSelectionViewModelObserver()
        let feeViewModelObserver = MockFeeViewModelObserver()

        // when

        let titleExpectation = XCTestExpectation()
        let assetSelectionExpectation = XCTestExpectation()
        let amountExpectation = XCTestExpectation()
        let feeExpectation = XCTestExpectation()
        let descriptionExpectation = XCTestExpectation()
        let accessoryExpectation = XCTestExpectation()
        let balanceLoadedExpectation = XCTestExpectation()
        let feeLoadingCompleteExpectation = XCTestExpectation()

        var feeViewModel: FeeViewModelProtocol?

        stub(view) { stub in
            when(stub).set(title: any(String.self)).then { _ in
                titleExpectation.fulfill()
            }

            when(stub).set(assetViewModel: any()).then { viewModel in
                viewModel.observable.add(observer: assetViewModelObserver)
                assetSelectionExpectation.fulfill()
            }

            when(stub).set(amountViewModel: any()).then { _ in
                amountExpectation.fulfill()
            }

            when(stub).set(feeViewModel: any()).then { viewModel in
                feeViewModel = viewModel
                viewModel.observable.add(observer: feeViewModelObserver)

                feeExpectation.fulfill()
            }

            when(stub).set(descriptionViewModel: any()).then { _ in
                descriptionExpectation.fulfill()
            }

            when(stub).set(accessoryViewModel: any()).then { _ in
                accessoryExpectation.fulfill()
            }

            when(stub).isSetup.get.thenReturn(false, true)

            if expectsFeeFailure {
                when(stub).showAlert(title: any(), message: any(), actions: any(), completion: any()).then { _ in
                    feeLoadingCompleteExpectation.fulfill()
                }
            }
        }

        stub(assetViewModelObserver) { stub in
            when(stub).assetSelectionDidChangeTitle().then {
                balanceLoadedExpectation.fulfill()
            }
        }

        stub(feeViewModelObserver) { stub in
            when(stub).feeTitleDidChange().thenDoNothing()

            when(stub).feeLoadingStateDidChange().then {
                if !expectsFeeFailure, feeViewModel?.isLoading == false {
                    feeLoadingCompleteExpectation.fulfill()
                }
            }
        }

        let assetSelectionFactory = AssetSelectionFactory(amountFormatterFactory: NumberFormatterFactory())

        let presenter = try WithdrawAmountPresenter(view: view,
                                                    coordinator: coordinator,
                                                    assets: accountSettings.assets,
                                                    selectedAsset: walletAsset,
                                                    selectedOption: withdrawOption,
                                                    dataProviderFactory: dataProviderFactory,
                                                    feeCalculationFactory: FeeCalculationFactory(),
                                                    withdrawViewModelFactory: viewModelFactory,
                                                    assetTitleFactory: assetSelectionFactory,
                                                    localizationManager: LocalizationManager(localization: WalletLanguage.english.rawValue))

        presenter.setup()

        // then

        wait(for: [titleExpectation,
                   assetSelectionExpectation,
                   amountExpectation,
                   feeExpectation,
                   descriptionExpectation,
                   accessoryExpectation,
                   balanceLoadedExpectation,
                   feeLoadingCompleteExpectation], timeout: Constants.networkTimeout)
    }
}
