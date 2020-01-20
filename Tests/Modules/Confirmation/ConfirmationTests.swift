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

            let networkOperationFactory = MiddlewareOperationFactory(accountSettings: accountSettings,
                                                                     networkResolver: networkResolver)

            let view = MockWalletFormViewProtocol()
            let coordinator = MockConfirmationCoordinatorProtocol()

            let resolver = MockResolverProtocol()

            let walletService = WalletService(operationFactory: networkOperationFactory)

            var transferInfo = try createRandomTransferInfo()
            transferInfo.source = accountSettings.accountId

            let transferPayload = TransferPayload(transferInfo: transferInfo,
                                                  receiverName: UUID().uuidString,
                                                  assetSymbol: accountSettings.assets[0].symbol)

            let accessoryViewModelFactory = ContactAccessoryViewModelFactory(style: WalletStyle().nameIconStyle,
                                                                             radius: AccessoryView.iconRadius)

            let eventCenter = WalletEventCenter()

            let transferObserver = MockWalletEventVisitorProtocol()

            let presenter = ConfirmationPresenter(view: view,
                                                  coordinator: coordinator,
                                                  service: walletService,
                                                  resolver: resolver,
                                                  payload: transferPayload,
                                                  accessoryViewModelFactory: accessoryViewModelFactory,
                                                  eventCenter: eventCenter,
                                                  feeDisplayStrategy: FeedDisplayStrategyIfNonzero())

            // when

            let setupExpectation = XCTestExpectation()
            let confirmExpectation = XCTestExpectation()
            let transferEventExpectation = XCTestExpectation()

            stub(view) { stub in
                when(stub).didReceive(viewModels: any([WalletFormViewModelProtocol].self)).then { _ in
                    setupExpectation.fulfill()
                }

                when(stub).didReceive(accessoryViewModel: any(AccessoryViewModelProtocol.self)).thenDoNothing()

                when(stub).didStartLoading().thenDoNothing()
                when(stub).didStopLoading().thenDoNothing()
                when(stub).isSetup.get.thenReturn(false, true)
            }

            stub(coordinator) { stub in
                when(stub).showResult(payload: any(TransferPayload.self)).then { _ in
                    confirmExpectation.fulfill()
                }
            }

            stub(resolver) { stub in
                when(stub).amountFormatter.get.thenReturn(NumberFormatter().localizableResource())
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
