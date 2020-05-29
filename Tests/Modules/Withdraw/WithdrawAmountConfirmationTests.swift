/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import XCTest
@testable import CommonWallet
import Cuckoo
import SoraFoundation

class WithdrawAmountConfirmationTests: NetworkBaseTests {

    func testSuccessfullAmountInput() {
        let networkResolver = MockNetworkResolver()
        performConfirmationTest(for: networkResolver,
                                transactionSettings: WalletTransactionSettings.defaultSettings,
                                inputAmount: "100",
                                inputDescription: "",
                                expectsSuccess: true)

        performConfirmationTest(for: networkResolver,
                                transactionSettings: WalletTransactionSettings.defaultSettings,
                                inputAmount: "100",
                                inputDescription: "Description",
                                expectsSuccess: true)
    }

    func testUnsufficientFundsInput() {
        let networkResolver = MockNetworkResolver()

        performConfirmationTest(for: networkResolver,
                                transactionSettings: WalletTransactionSettings.defaultSettings,
                                inputAmount: "100000",
                                inputDescription: "",
                                expectsSuccess: false)
    }

    func testFeeNotAvailable() {
        let networkResolver = MockNetworkResolver()
        performConfirmationTest(for: networkResolver,
                                transactionSettings: WalletTransactionSettings.defaultSettings,
                                inputAmount: "100",
                                inputDescription: "",
                                expectsSuccess: false) {
            try? WithdrawalMetadataMock.register(mock: .notAvailable,
                                                networkResolver: networkResolver,
                                                requestType: .withdrawalMetadata,
                                                httpMethod: .get,
                                                urlMockType: .regex)
        }
    }

    func testMinimumAmountInput() {
        let networkResolver = MockNetworkResolver()

        let settings = WalletTransactionSettings(limit: WalletTransactionLimit(minimum: 2, maximum: 1e+6))

        performConfirmationTest(for: networkResolver,
                                transactionSettings: settings,
                                inputAmount: "1",
                                inputDescription: "",
                                expectsSuccess: false)
    }

    func testFixedFeeTransfer() {
        let networkResolver = MockNetworkResolver()

        let settings = WalletTransactionSettings(limit: WalletTransactionLimit(minimum: 0, maximum: 1e+6))

        performConfirmationTest(for: networkResolver,
                                transactionSettings: settings,
                                inputAmount: "100",
                                inputDescription: "",
                                expectsSuccess: true,
                                metadataMock: .fixed,
                                expectedAmount: Decimal(string: "100")!,
                                expectedFee: Decimal(string: "1.0")!)
    }

    func testFactorFeeTransfer() {
        let networkResolver = MockNetworkResolver()

        let settings = WalletTransactionSettings(limit: WalletTransactionLimit(minimum: 0, maximum: 1e+6))

        performConfirmationTest(for: networkResolver,
                                transactionSettings: settings,
                                inputAmount: "90",
                                inputDescription: "",
                                expectsSuccess: true,
                                metadataMock: .factor,
                                expectedAmount: Decimal(string: "90")!,
                                expectedFee: Decimal(string: "9")!)
    }

    func testTaxFeeTransfer() {
        let networkResolver = MockNetworkResolver()

        let settings = WalletTransactionSettings(limit: WalletTransactionLimit(minimum: 0, maximum: 1e+6))

        performConfirmationTest(for: networkResolver,
                                transactionSettings: settings,
                                inputAmount: "80",
                                inputDescription: "",
                                expectsSuccess: true,
                                metadataMock: .tax,
                                expectedAmount: Decimal(string: "79.2")!,
                                expectedFee: Decimal(string: "0.8")!)
    }

    // MARK: Private

    private func performConfirmationTest(for networkResolver: MiddlewareNetworkResolverProtocol,
                                         transactionSettings: WalletTransactionSettingsProtocol,
                                         inputAmount: String,
                                         inputDescription: String,
                                         expectsSuccess: Bool,
                                         metadataMock: WithdrawalMetadataMock = .success,
                                         expectedAmount: Decimal? = nil,
                                         expectedFee: Decimal? = nil,
                                         beforeConfirmationBlock: (() -> Void)? = nil) {
        do {
            // given

            let walletAsset = WalletAsset(identifier: Constants.soraAssetId,
                                          name: LocalizableResource { _ in UUID().uuidString },
                                          platform: LocalizableResource { _ in UUID().uuidString },
                                          symbol: "A",
                                          precision: 2)
            let withdrawOption = createRandomWithdrawOption()

            let accountSettings = try createRandomAccountSettings(for: [walletAsset],
                                                                  withdrawOptions: [withdrawOption])

            let selectedAsset = accountSettings.assets.first!
            let selectionOption = accountSettings.withdrawOptions.first!

            let cacheFacade = CoreDataTestCacheFacade()

            let operationSettings = try createRandomOperationSettings()

            let networkOperationFactory = MiddlewareOperationFactory(accountSettings: accountSettings,
                                                                     operationSettings: operationSettings,
                                                                     networkResolver: networkResolver)

            let dataProviderFactory = DataProviderFactory(accountSettings: accountSettings,
                                                          cacheFacade: cacheFacade,
                                                          networkOperationFactory: networkOperationFactory,
                                                          identifierFactory: SingleProviderIdentifierFactory())

            let inputValidatorFactory = WalletInputValidatorFactoryDecorator(descriptionMaxLength: 64)
            let viewModelFactory = WithdrawAmountViewModelFactory(amountFormatterFactory: NumberFormatterFactory(),
                                                                  option: selectionOption,
                                                                  descriptionValidatorFactory: inputValidatorFactory,
                                                                  transactionSettings: transactionSettings,
                                                                  feeDisplaySettingsFactory: FeeDisplaySettingsFactory())

            let view = MockWithdrawViewProtocol()
            let coordinator = MockWithdrawCoordinatorProtocol()

            // when

            try FetchBalanceMock.register(mock: .success,
                                          networkResolver: networkResolver,
                                          requestType: .balance,
                                          httpMethod: .post)

            try WithdrawalMetadataMock.register(mock: metadataMock,
                                                networkResolver: networkResolver,
                                                requestType: .withdrawalMetadata,
                                                httpMethod: .get,
                                                urlMockType: .regex)

            let assetSelectionExpectation = XCTestExpectation()
            assetSelectionExpectation.expectedFulfillmentCount = 2

            let amountExpectation = XCTestExpectation()
            let descriptionExpectation = XCTestExpectation()
            let accessoryExpectation = XCTestExpectation()
            let errorExpectation = XCTestExpectation()
            
            let feeLoadedExpectation = XCTestExpectation()

            var amountViewModel: AmountInputViewModelProtocol?
            var descriptionViewModel: DescriptionInputViewModelProtocol?

            stub(view) { stub in
                when(stub).set(assetViewModel: any()).then { viewModel in
                    assetSelectionExpectation.fulfill()
                }

                when(stub).set(amountViewModel: any()).then { viewModel in
                    amountViewModel = viewModel

                    amountExpectation.fulfill()
                }

                when(stub).set(feeViewModels: any()).then { viewModels in
                    guard let viewModel = viewModels.first else {
                        return
                    }

                    feeLoadedExpectation.fulfill()
                    XCTAssertTrue(viewModels.count == 1)
                    XCTAssertTrue(!viewModel.isLoading)
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

                when(stub).setAssetHeader(any()).thenDoNothing()
                when(stub).presentAssetError(any()).thenDoNothing()

                when(stub).setAmountHeader(any()).thenDoNothing()
                when(stub).presentAmountError(any()).thenDoNothing()

                when(stub).setFeeHeader(any(), at: any()).thenDoNothing()
                when(stub).presentFeeError(any(), at: any()).thenDoNothing()

                when(stub).setDescriptionHeader(any()).thenDoNothing()
                when(stub).presentDescriptionError(any()).thenDoNothing()

                when(stub).isSetup.get.thenReturn(false, true)

                when(stub).didStartLoading().thenDoNothing()
                when(stub).didStopLoading().thenDoNothing()
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

            let presenter = try WithdrawPresenter(view: view,
                                                  coordinator: coordinator,
                                                  assets: accountSettings.assets,
                                                  selectedAsset: selectedAsset,
                                                  selectedOption: selectionOption,
                                                  dataProviderFactory: dataProviderFactory,
                                                  feeCalculationFactory: FeeCalculationFactory(),
                                                  viewModelFactory: viewModelFactory,
                                                  localizationManager: LocalizationManager(localization: WalletLanguage.english.rawValue))

            // then

            presenter.setup()

            wait(for: [assetSelectionExpectation,
                       amountExpectation,
                       descriptionExpectation,
                       accessoryExpectation,
                       feeLoadedExpectation], timeout: Constants.networkTimeout)

            XCTAssertNil(presenter.confirmationState)

            _ = amountViewModel?.didReceiveReplacement(inputAmount, for: NSRange(location: 0, length: 0))
            _ = descriptionViewModel?.didReceiveReplacement(description, for: NSRange(location: 0, length: 0))

            beforeConfirmationBlock?()

            presenter.proceed()

            XCTAssertEqual(presenter.confirmationState, .waiting)

            if expectsSuccess {
                wait(for: [confirmExpectation], timeout: Constants.networkTimeout)
                
                if let expectedAmount = expectedAmount {
                    XCTAssertEqual(expectedAmount, infoToConfirm?.amount.decimalValue)
                }

                if let expectedFee = expectedFee {
                    XCTAssertEqual(expectedFee, infoToConfirm?.fees.first?.value.decimalValue)
                }

            } else {
                wait(for: [errorExpectation], timeout: Constants.networkTimeout)
            }

            XCTAssertNil(presenter.confirmationState)

        } catch {
            XCTFail("Did receive error \(error)")
        }
    }
}
