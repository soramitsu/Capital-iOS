/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import XCTest
@testable import CommonWallet
import SoraFoundation
import Cuckoo

class TransferFeeEditingTests: NetworkBaseTests {

    func testStartEditing() throws {
        // given

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

        let changeHandler = OperationDefinitionChangeHandler()
        let mockChangeHandler = MockOperationDefinitionChangeHandling()
        let mockFeeEditing = MockFeeEditing()

        var feeEditingDelegate: FeeEditingDelegate?

        stub(mockFeeEditing) { stub in
            when(stub).delegate.set(any()).then { delegate in
                feeEditingDelegate = delegate
            }

            when(stub).delegate.get.thenReturn(feeEditingDelegate)

            when(stub).startEditing(feeDescription: any()).then { feeDescription in
                feeEditingDelegate?.feeEditing(mockFeeEditing, didEdit: feeDescription)
            }
        }

        stub(mockChangeHandler) { stub in
            when(stub).updateContentForChange(event: any()).then { event in
                changeHandler.updateContentForChange(event: event)
            }

            when(stub).clearErrorForChange(event: any()).then { event in
                changeHandler.clearErrorForChange(event: event)
            }

            when(stub).shouldUpdateAccessoryForChange(event: any()).then { event in
                changeHandler.shouldUpdateAccessoryForChange(event: event)
            }
        }

        let presenter = try performTestSetup(for: mockFeeEditing,
                                             changeHandling: mockChangeHandler,
                                             networkResolver: networkResolver)

        // when

        let completionExpectation = XCTestExpectation()

        stub(mockChangeHandler) { stub in
            when(stub).updateContentForChange(event: any()).then { event in
                if event == .metadata {
                    completionExpectation.fulfill()
                }

                return changeHandler.updateContentForChange(event: event)
            }
        }

        presenter.presentFeeEditing(at: 0)

        // then

        wait(for: [completionExpectation], timeout: Constants.networkTimeout)
    }

    // MARK: Private

    private func performTestSetup(for feeEditing: FeeEditing,
                                  changeHandling: OperationDefinitionChangeHandling,
                                  networkResolver: MiddlewareNetworkResolverProtocol) throws
        -> TransferPresenter {
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

        // when

        let assetExpectation = XCTestExpectation()
        assetExpectation.expectedFulfillmentCount = 2

        let amountExpectation = XCTestExpectation()
        let descriptionExpectation = XCTestExpectation()
        let accessoryExpectation = XCTestExpectation()

        let feeLoadingCompleteExpectation = XCTestExpectation()

        stub(view) { stub in
            when(stub).set(assetViewModel: any()).then { assetViewModel in
                assetExpectation.fulfill()
            }

            when(stub).set(amountViewModel: any()).then { viewModel in
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

        let presenter = try TransferPresenter(view: view,
                                              coordinator: coordinator,
                                              assets: accountSettings.assets,
                                              accountId: accountSettings.accountId,
                                              payload: amountPayload,
                                              dataProviderFactory: dataProviderFactory,
                                              feeCalculationFactory: FeeCalculationFactory(),
                                              resultValidator: validator,
                                              changeHandler: changeHandling,
                                              viewModelFactory: transferViewModelFactory,
                                              headerFactory: TransferDefinitionHeaderModelFactory(),
                                              receiverPosition: .accessoryBar,
                                              localizationManager: LocalizationManager(localization: WalletLanguage.english.rawValue),
                                              errorHandler: nil,
                                              feeEditing: feeEditing)

        presenter.setup()

        // then

        wait(for: [assetExpectation,
                   amountExpectation,
                   descriptionExpectation,
                   accessoryExpectation,
                   feeLoadingCompleteExpectation],
             timeout: Constants.networkTimeout)

        return presenter
    }

}
