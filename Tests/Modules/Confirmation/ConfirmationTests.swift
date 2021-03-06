/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo
import SoraFoundation

class ConfirmationTests: NetworkBaseTests {

    func testSetupAndConfirm() {
        do {
            // given

            let accountSettings = try createRandomAccountSettings(for: 1)
            let networkResolver = MockNetworkResolver()
            let operationSettings = try createRandomOperationSettings()

            let networkOperationFactory = MiddlewareOperationFactory(accountSettings: accountSettings,
                                                                     operationSettings: operationSettings,
                                                                     networkResolver: networkResolver)

            let view = MockWalletNewFormViewProtocol()
            let coordinator = MockTransferConfirmationCoordinatorProtocol()

            let resolver = MockResolverProtocol()

            let walletService = WalletService(operationFactory: networkOperationFactory)

            let transferInfo = try createRandomTransferInfo(for: accountSettings.accountId)

            let transferPayload = ConfirmationPayload(transferInfo: transferInfo,
                                                      receiverName: UUID().uuidString)

            let eventCenter = WalletEventCenter()

            let transferObserver = MockWalletEventVisitorProtocol()

            let generatingIconStyle = WalletStyle().nameIconStyle

            let feeDisplayFactory = FeeDisplaySettingsFactory()

            let numberFormatterFactory = NumberFormatterFactory()

            let viewModelFactory = TransferConfirmationViewModelFactory(assets: accountSettings.assets,
                                                                        feeDisplayFactory: feeDisplayFactory,
                                                                        generatingIconStyle: generatingIconStyle,
                                                                        amountFormatterFactory: numberFormatterFactory)

            let presenter = TransferConfirmationPresenter(view: view,
                                                          coordinator: coordinator,
                                                          service: walletService,
                                                          payload: transferPayload,
                                                          eventCenter: eventCenter,
                                                          viewModelFactory: viewModelFactory)

            // when

            let setupExpectation = XCTestExpectation()
            let confirmExpectation = XCTestExpectation()
            let transferEventExpectation = XCTestExpectation()

            stub(view) { stub in
                when(stub).didReceive(viewModels: any([WalletFormViewBindingProtocol].self)).then { _ in
                    setupExpectation.fulfill()
                }

                when(stub).didReceive(accessoryViewModel: any(AccessoryViewModelProtocol.self)).thenDoNothing()

                when(stub).didStartLoading().thenDoNothing()
                when(stub).didStopLoading().thenDoNothing()
                when(stub).isSetup.get.thenReturn(false, true)
            }

            stub(coordinator) { stub in
                when(stub).proceed(payload: any(ConfirmationPayload.self)).then { _ in
                    confirmExpectation.fulfill()
                }
            }

            stub(resolver) { stub in
                when(stub).account.get.thenReturn(accountSettings)
                when(stub).amountFormatterFactory.get.thenReturn(NumberFormatterFactory())
                when(stub).statusDateFormatter.get.thenReturn(DateFormatter().localizableResource())
                when(stub).style.get.thenReturn(WalletStyle())
            }

            stub(transferObserver) { stub in
                stub.processTransferComplete(event: any()).then { _ in
                    transferEventExpectation.fulfill()
                }
            }

            try TransferMock.register(mock: .success,
                                      networkResolver: networkResolver,
                                      requestType: .transfer,
                                      httpMethod: .post)

            eventCenter.add(observer: transferObserver, dispatchIn: nil)

            presenter.localizationManager = LocalizationManager(localization: WalletLanguage.english.rawValue)

            presenter.setup()

            // then

            wait(for: [setupExpectation], timeout: Constants.networkTimeout)

            // when

            presenter.performAction()

            // then

            wait(for: [confirmExpectation, transferEventExpectation], timeout: Constants.networkTimeout)

        } catch {
            XCTFail("\(error)")
        }
    }

}
