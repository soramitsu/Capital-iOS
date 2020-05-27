/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import XCTest
@testable import CommonWallet
import SoraFoundation
import Cuckoo

class TransferViewModelTests: XCTestCase {

    func testAssetViewModelForSingleAsset() throws {
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

        let view = MockTransferViewProtocol()

        let account = try createRandomAccountSettings(for: 1)

        let presenter = try createPresenter(for: view,
                                            networkResolver: networkResolver,
                                            assets: account.assets)

        // when

        let expectation = XCTestExpectation()

        stub(view) { stub in
            when(stub).set(assetViewModel: any()).then { assetViewModel in
                XCTAssertFalse(assetViewModel.state.canSelect)
                expectation.fulfill()
            }
        }


        presenter.setup()

        // then

        wait(for: [expectation], timeout: Constants.networkTimeout)
    }

    func testAssetViewModelForSeveralAsset() throws {
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

        let view = MockTransferViewProtocol()

        let account = try createRandomAccountSettings(for: 2)

        let presenter = try createPresenter(for: view,
                                            networkResolver: networkResolver,
                                            assets: account.assets)

        // when

        let expectation = XCTestExpectation()


        stub(view) { stub in
            when(stub).set(assetViewModel: any()).then { assetViewModel in
                XCTAssertTrue(assetViewModel.state.canSelect)
                expectation.fulfill()
            }
        }


        presenter.setup()

        // then

        wait(for: [expectation], timeout: Constants.networkTimeout)
    }

    // MARK: Private

    private func createPresenter(for view: MockTransferViewProtocol,
                                 networkResolver: MockNetworkResolver,
                                 assets: [WalletAsset]) throws -> TransferPresenter {

        let accountSettings = try createRandomAccountSettings(for: assets, withdrawOptions: [])

        let cacheFacade = CoreDataTestCacheFacade()

        let operationSettings = try createRandomOperationSettings()
        let networkOperationFactory = MiddlewareOperationFactory(accountSettings: accountSettings,
                                                                 operationSettings: operationSettings,
                                                                 networkResolver: networkResolver)

        let dataProviderFactory = DataProviderFactory(accountSettings: accountSettings,
                                                      cacheFacade: cacheFacade,
                                                      networkOperationFactory: networkOperationFactory)

        let coordinator = MockTransferCoordinatorProtocol()

        stub(view) { stub in
            when(stub).set(assetViewModel: any()).thenDoNothing()
            when(stub).set(amountViewModel: any()).thenDoNothing()
            when(stub).set(descriptionViewModel: any()).thenDoNothing()
            when(stub).set(accessoryViewModel: any()).thenDoNothing()
            when(stub).set(feeViewModels: any()).thenDoNothing()
            when(stub).setAssetHeader(any()).thenDoNothing()
            when(stub).presentAssetError(any()).thenDoNothing()
            when(stub).setAmountHeader(any()).thenDoNothing()
            when(stub).presentAmountError(any()).thenDoNothing()
            when(stub).setFeeHeader(any(), at: any()).thenDoNothing()
            when(stub).presentFeeError(any(), at: any()).thenDoNothing()
            when(stub).setDescriptionHeader(any()).thenDoNothing()
            when(stub).presentDescriptionError(any()).thenDoNothing()
            when(stub).isSetup.get.thenReturn(false, true)
        }

        let recieverInfo = try createRandomReceiveInfo()
        let amountPayload = TransferPayload(receiveInfo: recieverInfo, receiverName: UUID().uuidString)
        let settings = WalletTransactionSettings.defaultSettings

        let inputValidatorFactory = WalletInputValidatorFactoryDecorator(descriptionMaxLength: 64)
        let transferViewModelFactory = TransferViewModelFactory(account: accountSettings,
                                                                amountFormatterFactory: NumberFormatterFactory(),
                                                              descriptionValidatorFactory: inputValidatorFactory,
                                                              feeDisplaySettingsFactory: FeeDisplaySettingsFactory(),
                                                              transactionSettings: settings,
                                                              generatingIconStyle: WalletStyle().nameIconStyle)
        let resultValidator = TransferValidator(transactionSettings: settings)
        let changeHandler = OperationDefinitionChangeHandler()

        let presenter = try TransferPresenter(view: view,
                                              coordinator: coordinator,
                                              assets: accountSettings.assets,
                                              accountId: accountSettings.accountId,
                                              payload: amountPayload,
                                              dataProviderFactory: dataProviderFactory,
                                              feeCalculationFactory: FeeCalculationFactory(),
                                              resultValidator: resultValidator,
                                              changeHandler: changeHandler,
                                              viewModelFactory: transferViewModelFactory,
                                              headerFactory: TransferDefinitionHeaderModelFactory(),
                                              receiverPosition: .accessoryBar,
                                              localizationManager: LocalizationManager(localization: WalletLanguage.english.rawValue),
                                              errorHandler: nil,
                                              feeEditing: nil)

        return presenter
    }
}
