/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo
import SoraFoundation

class TransferSetupTests: NetworkBaseTests {

    func testPerformSuccessfullSetup() {
        do {
            let networkResolver = MockNetworkResolver()

            try FetchBalanceMock.register(mock: .success,
                                          networkResolver: networkResolver,
                                          requestType: .balance,
                                          httpMethod: .post)

            try TransferMetadataMock.register(mock: .success,
                                              networkResolver: networkResolver,
                                              requestType: .transferMetadata,
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

            try TransferMetadataMock.register(mock: .notAvailable,
                                              networkResolver: networkResolver,
                                              requestType: .transferMetadata,
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
        let accountSettings = try createRandomAccountSettings(for: [walletAsset],
                                                              withdrawOptions: [])

        let cacheFacade = CoreDataTestCacheFacade()

        let operationSettings = try createRandomOperationSettings()
        let networkOperationFactory = MiddlewareOperationFactory(accountSettings: accountSettings,
                                                                 operationSettings: operationSettings,
                                                                 networkResolver: networkResolver)

        let dataProviderFactory = DataProviderFactory(accountSettings: accountSettings,
                                                      cacheFacade: cacheFacade,
                                                      networkOperationFactory: networkOperationFactory,
                                                      identifierFactory: SingleProviderIdentifierFactory())

        let view = MockTransferViewProtocol()
        let coordinator = MockTransferCoordinatorProtocol()
        let errorHandler = MockOperationDefinitionErrorHandling()

        // when

        let assetExpectation = XCTestExpectation()
        assetExpectation.expectedFulfillmentCount = 2

        let amountExpectation = XCTestExpectation()
        let descriptionExpectation = XCTestExpectation()
        let accessoryExpectation = XCTestExpectation()

        let feeLoadingCompleteExpectation = XCTestExpectation()

        var amountViewModel: AmountInputViewModelProtocol? = nil

        stub(view) { stub in
            when(stub).set(assetViewModel: any()).then { assetViewModel in
                assetExpectation.fulfill()
            }

            when(stub).set(amountViewModel: any()).then { viewModel in
                amountViewModel = viewModel

                amountExpectation.fulfill()
            }

            when(stub).set(descriptionViewModel: any()).then { _ in
                descriptionExpectation.fulfill()
            }

            when(stub).set(accessoryViewModel: any()).then { _ in
                accessoryExpectation.fulfill()
            }

            when(stub).set(feeViewModels: any()).then { viewModels in
                guard let viewModel = viewModels.first else {
                    return
                }

                feeLoadingCompleteExpectation.fulfill()
                XCTAssertTrue(viewModels.count == 1)
                XCTAssertTrue(!viewModel.isLoading)
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

            when(stub).showAlert(title: any(),
                                 message: any(),
                                 actions: any(),
                                 completion: any()).thenDoNothing()
        }

        if expectsFeeFailure {
            stub(errorHandler) { stub in
                when(stub).mapError(any(), locale: any()).then { _ in
                    feeLoadingCompleteExpectation.fulfill()
                    return nil
                }
            }
        }

        let recieverInfo = try createRandomReceiveInfo()
        let amountPayload = TransferPayload(receiveInfo: recieverInfo, receiverName: UUID().uuidString)

        let inputValidatorFactory = WalletInputValidatorFactoryDecorator(descriptionMaxLength: 64)
        let settings = WalletTransactionSettings.defaultSettings

        let transferViewModelFactory = TransferViewModelFactory(accountId: accountSettings.accountId,
                                                                assets: accountSettings.assets,
                                                                amountFormatterFactory: NumberFormatterFactory(),
                                                              descriptionValidatorFactory: inputValidatorFactory,
                                                              feeDisplaySettingsFactory: FeeDisplaySettingsFactory(),
                                                              transactionSettings: settings,
                                                              generatingIconStyle: WalletStyle().nameIconStyle)

        let validator = TransferValidator(transactionSettings: WalletTransactionSettings.defaultSettings)
        let changeHandler = OperationDefinitionChangeHandler()

        let presenter = try TransferPresenter(view: view,
                                              coordinator: coordinator,
                                              assets: accountSettings.assets,
                                              accountId: accountSettings.accountId,
                                              payload: amountPayload,
                                              dataProviderFactory: dataProviderFactory,
                                              feeCalculationFactory: FeeCalculationFactory(),
                                              resultValidator: validator,
                                              changeHandler: changeHandler,
                                              viewModelFactory: transferViewModelFactory,
                                              headerFactory: TransferDefinitionHeaderModelFactory(),
                                              receiverPosition: .accessoryBar,
                                              localizationManager: LocalizationManager(localization: WalletLanguage.english.rawValue),
                                              errorHandler: errorHandler,
                                              feeEditing: nil)

        presenter.setup()

        // then

        wait(for: [assetExpectation,
                   amountExpectation,
                   descriptionExpectation,
                   accessoryExpectation,
                   feeLoadingCompleteExpectation],
             timeout: Constants.networkTimeout)

        guard let expectedAmount = recieverInfo.amount else {
            XCTFail("Unexpected initial amount")
            return
        }

        XCTAssertEqual(amountViewModel?.displayAmount, expectedAmount.stringValue)
    }
}
