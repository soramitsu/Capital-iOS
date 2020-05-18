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
                                      name: LocalizableResource { _ in UUID().uuidString },
                                      platform: LocalizableResource { _ in UUID().uuidString },
                                      symbol: "A",
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
        let settings = WalletTransactionSettings.defaultSettings

        let viewModelFactory = WithdrawAmountViewModelFactory(amountFormatterFactory: NumberFormatterFactory(),
                                                              option: withdrawOption,
                                                              descriptionValidatorFactory: inputValidatorFactory,
                                                              transactionSettings: settings,
                                                              feeDisplaySettingsFactory: FeeDisplaySettingsFactory())

        let view = MockWithdrawViewProtocol()
        let coordinator = MockWithdrawCoordinatorProtocol()

        // when

        let assetSelectionExpectation = XCTestExpectation()
        assetSelectionExpectation.expectedFulfillmentCount = 2

        let amountExpectation = XCTestExpectation()
        let descriptionExpectation = XCTestExpectation()
        let accessoryExpectation = XCTestExpectation()
        let feeLoadingCompleteExpectation = XCTestExpectation()

        stub(view) { stub in

            when(stub).set(assetViewModel: any()).then { viewModel in
                assetSelectionExpectation.fulfill()
            }

            when(stub).set(amountViewModel: any()).then { _ in
                amountExpectation.fulfill()
            }

            when(stub).set(feeViewModels: any()).then { viewModels in
                guard let viewModel = viewModels.first else {
                    return
                }

                feeLoadingCompleteExpectation.fulfill()
                XCTAssertTrue(!viewModel.isLoading)
                XCTAssertTrue(viewModels.count == 1)
            }

            when(stub).set(descriptionViewModel: any()).then { _ in
                descriptionExpectation.fulfill()
            }

            when(stub).set(accessoryViewModel: any()).then { _ in
                accessoryExpectation.fulfill()
            }

            when(stub).setAssetHeader(any()).thenDoNothing()
            when(stub).presentAssetError(any()).thenDoNothing()

            when(stub).setAmountHeader(any()).thenDoNothing()
            when(stub).presentAmountError(any()).thenDoNothing()

            when(stub).setFeeHeader(any(), at: any()).thenDoNothing()
            when(stub).presentFeeError(any(), at: any()).thenDoNothing()

            when(stub).setDescriptionHeader(any()).thenDoNothing()
            when(stub).presentDescriptionError(any()).thenDoNothing()

            when(stub).isSetup.get.thenReturn(false, true)

            if expectsFeeFailure {
                when(stub).showAlert(title: any(), message: any(), actions: any(), completion: any()).then { _ in
                    feeLoadingCompleteExpectation.fulfill()
                }
            }
        }

        let assetSelectionFactory = AssetSelectionFactory(amountFormatterFactory: NumberFormatterFactory())

        let presenter = try WithdrawPresenter(view: view,
                                              coordinator: coordinator,
                                              assets: accountSettings.assets,
                                              selectedAsset: walletAsset,
                                              selectedOption: withdrawOption,
                                              dataProviderFactory: dataProviderFactory,
                                              feeCalculationFactory: FeeCalculationFactory(),
                                              withdrawViewModelFactory: viewModelFactory,
                                              assetSelectionFactory: assetSelectionFactory,
                                              localizationManager: LocalizationManager(localization: WalletLanguage.english.rawValue))

        presenter.setup()

        // then

        wait(for: [assetSelectionExpectation], timeout: Constants.networkTimeout)
        wait(for: [amountExpectation], timeout: Constants.networkTimeout)
        wait(for: [descriptionExpectation], timeout: Constants.networkTimeout)
        wait(for: [accessoryExpectation], timeout: Constants.networkTimeout)
        wait(for: [feeLoadingCompleteExpectation], timeout: Constants.networkTimeout)
    }
}
