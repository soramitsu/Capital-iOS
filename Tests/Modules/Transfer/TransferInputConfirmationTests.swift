/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo
import SoraFoundation

class TransferInputConfirmationTests: NetworkBaseTests {

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

    func testMinimumAmountInput() {
        let networkResolver = MockNetworkResolver()

        let settings = WalletTransactionSettings(limit: WalletTransactionLimit(minimum: 10, maximum: 1e+6))

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
                                expectedFee: Decimal(string: "0.9")!)
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
                                expectedAmount: Decimal(string: "72")!,
                                expectedFee: Decimal(string: "8")!)
    }

    // MARK: Private

    private func performConfirmationTest(for networkResolver: MiddlewareNetworkResolverProtocol,
                                         transactionSettings: WalletTransactionSettingsProtocol,
                                         inputAmount: String,
                                         inputDescription: String,
                                         expectsSuccess: Bool,
                                         metadataMock: TransferMetadataMock = .success,
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
            let accountSettings = try createRandomAccountSettings(for: [walletAsset],
                                                                  withdrawOptions: [])

            let cacheFacade = CoreDataTestCacheFacade()

            let operationSettings = try createRandomOperationSettings()

            let networkOperationFactory = MiddlewareOperationFactory(accountSettings: accountSettings,
                                                                     operationSettings: operationSettings,
                                                                     networkResolver: networkResolver)

            let dataProviderFactory = DataProviderFactory(accountSettings: accountSettings,
                                                          cacheFacade: cacheFacade,
                                                          networkOperationFactory: networkOperationFactory)

            let assetSelectionFactory = AssetSelectionFactory(amountFormatterFactory: NumberFormatterFactory())
            let accessoryViewModelFactory = ContactAccessoryViewModelFactory(style: WalletStyle().nameIconStyle)

            let view = MockTransferViewProtocol()
            let coordinator = MockTransferCoordinatorProtocol()
            let errorHandler = MockOperationDefinitionErrorHandling()

            try FetchBalanceMock.register(mock: .success,
                                          networkResolver: networkResolver,
                                          requestType: .balance,
                                          httpMethod: .post)

            try TransferMetadataMock.register(mock: metadataMock,
                                              networkResolver: networkResolver,
                                              requestType: .transferMetadata,
                                              httpMethod: .get,
                                              urlMockType: .regex)

            // when

            let assetExpectation = XCTestExpectation()
            assetExpectation.expectedFulfillmentCount = 2

            let amountExpectation = XCTestExpectation()
            let descriptionExpectation = XCTestExpectation()
            let errorExpectation = XCTestExpectation()
            let accessoryExpectation = XCTestExpectation()

            let feeLoadedExpectation = XCTestExpectation()

            var amountViewModel: AmountInputViewModelProtocol?
            var descriptionViewModel: DescriptionInputViewModelProtocol?

            stub(view) { stub in
                when(stub).set(assetViewModel: any()).then { assetViewModel in
                    assetExpectation.fulfill()
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

                when(stub).showAlert(title: any(),
                                     message: any(),
                                     actions: any(),
                                     completion: any()).thenDoNothing()

                when(stub).setAssetHeader(any()).thenDoNothing()
                when(stub).presentAssetError(any()).thenDoNothing()

                when(stub).setAmountHeader(any()).thenDoNothing()
                when(stub).presentAmountError(any()).thenDoNothing()

                when(stub).setFeeHeader(any(), at: any()).thenDoNothing()
                when(stub).presentFeeError(any(), at: any()).thenDoNothing()

                when(stub).setDescriptionHeader(any()).thenDoNothing()
                when(stub).presentDescriptionError(any()).thenDoNothing()

                when(stub).didStartLoading().thenDoNothing()
                when(stub).didStopLoading().thenDoNothing()

                when(stub).controller.get.thenReturn(UIViewController())

                when(stub).isSetup.get.thenReturn(false, true)
            }

            stub(errorHandler) { stub in
                when(stub).mapError(any(), locale: any()).then { _ in
                    errorExpectation.fulfill()
                    return nil
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
            let transferViewModelFactory = TransferViewModelFactory(amountFormatterFactory: NumberFormatterFactory(),
                                                                  descriptionValidatorFactory: inputValidatorFactory,
                                                                  feeDisplaySettingsFactory: FeeDisplaySettingsFactory(),
                                                                  transactionSettings: transactionSettings)

            let validator = TransferValidator(transactionSettings: transactionSettings)
            let changeHandler = OperationDefinitionChangeHandler()
            let localizationManager = LocalizationManager(localization: WalletLanguage.english.rawValue)

            let presenter = try TransferPresenter(view: view,
                                                  coordinator: coordinator,
                                                  payload: amountPayload,
                                                  dataProviderFactory: dataProviderFactory,
                                                  feeCalculationFactory: FeeCalculationFactory(),
                                                  account: accountSettings,
                                                  resultValidator: validator,
                                                  changeHandler: changeHandler,
                                                  transferViewModelFactory: transferViewModelFactory,
                                                  assetSelectionFactory: assetSelectionFactory,
                                                  accessoryFactory: accessoryViewModelFactory,
                                                  headerFactory: TransferDefinitionHeaderModelFactory(),
                                                  receiverPosition: .accessoryBar,
                                                  localizationManager: localizationManager,
                                                  errorHandler: errorHandler,
                                                  feeEditing: nil)

            presenter.setup()

            wait(for: [assetExpectation,
                       amountExpectation,
                       descriptionExpectation,
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

            presenter.proceed()

            XCTAssertEqual(presenter.confirmationState, .waiting)

            if expectsSuccess {
                wait(for: [confirmExpectation], timeout: Constants.networkTimeout)

                if let expectedAmount = expectedAmount {
                    XCTAssertEqual(expectedAmount, payloadToConfirm?.transferInfo.amount.decimalValue)
                }

                if let expectedFee = expectedFee {
                    XCTAssertEqual(expectedFee, payloadToConfirm?.transferInfo.fees.first?.value.decimalValue)
                }
            } else {
                wait(for: [errorExpectation], timeout: Constants.networkTimeout)
            }

            XCTAssertNil(presenter.confirmationState)

        } catch {
            XCTFail("\(error)")
        }
    }
}
