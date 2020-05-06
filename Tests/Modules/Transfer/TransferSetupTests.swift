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
        do {
            // given

            let walletAsset = WalletAsset(identifier: Constants.soraAssetId,
                                          symbol: "A",
                                          details: LocalizableResource { _ in UUID().uuidString },
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
            let accessoryViewModelFactory = ContactAccessoryViewModelFactory(style: WalletStyle().nameIconStyle,
                                                                             radius: AccessoryView.iconRadius)

            let view = MockTransferViewProtocol()
            let coordinator = MockTransferCoordinatorProtocol()

            let assetSelectionObserver = MockAssetSelectionViewModelObserver()
            let feeViewModelObserver = MockFeeViewModelObserver()

            // when

            let assetExpectation = XCTestExpectation()
            let amountExpectation = XCTestExpectation()
            let feeExpectation = XCTestExpectation()
            let descriptionExpectation = XCTestExpectation()
            let accessoryExpectation = XCTestExpectation()

            let balanceExpectation = XCTestExpectation()
            let feeLoadingCompleteExpectation = XCTestExpectation()

            var feeViewModel: FeeViewModelProtocol?

            var amountViewModel: AmountInputViewModelProtocol? = nil

            stub(view) { stub in
                when(stub).set(assetViewModel: any()).then { assetViewModel in
                    assetViewModel.observable.add(observer: assetSelectionObserver)

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
                    feeViewModel = viewModels.first
                    feeViewModel?.observable.add(observer: feeViewModelObserver)

                    feeExpectation.fulfill()
                }

                when(stub).isSetup.get.thenReturn(false, true)

                if expectsFeeFailure {
                    when(stub).showAlert(title: any(), message: any(), actions: any(), completion: any()).then { _ in
                        feeLoadingCompleteExpectation.fulfill()
                    }
                }
            }

            stub(assetSelectionObserver) { stub in
                when(stub).assetSelectionDidChangeTitle().then { title in
                    balanceExpectation.fulfill()
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

            let recieverInfo = try createRandomReceiveInfo()
            let amountPayload = AmountPayload(receiveInfo: recieverInfo, receiverName: UUID().uuidString)

            let inputValidatorFactory = WalletInputValidatorFactoryDecorator(descriptionMaxLength: 64)
            let transferViewModelFactory = AmountViewModelFactory(amountFormatterFactory: NumberFormatterFactory(),
                                                                  descriptionValidatorFactory: inputValidatorFactory,
                                                                  transactionSettingsFactory: WalletTransactionSettingsFactory(),
                                                                  feeDisplaySettingsFactory: FeeDisplaySettingsFactory())

            let presenter = try TransferPresenter(view: view,
                                                  coordinator: coordinator,
                                                  payload: amountPayload,
                                                  dataProviderFactory: dataProviderFactory,
                                                  feeCalculationFactory: FeeCalculationFactory(),
                                                  account: accountSettings,
                                                  transferViewModelFactory: transferViewModelFactory,
                                                  assetSelectionFactory: assetSelectionFactory,
                                                  accessoryFactory: accessoryViewModelFactory,
                                                  titleFactory: TransferDefinitionTitleModelFactory(),
                                                  receiverPosition: .accessoryBar,
                                                  localizationManager: LocalizationManager(localization: WalletLanguage.english.rawValue))

            presenter.setup()

            // then

            wait(for: [assetExpectation,
                       amountExpectation,
                       feeExpectation,
                       descriptionExpectation,
                       balanceExpectation,
                       accessoryExpectation,
                       feeLoadingCompleteExpectation],
                 timeout: Constants.networkTimeout)

            guard let expectedAmount = recieverInfo.amount else {
                XCTFail("Unexpected initial amount")
                return
            }

            XCTAssertEqual(amountViewModel?.displayAmount, expectedAmount.stringValue)

        } catch {
            XCTFail("\(error)")
        }
    }
}
