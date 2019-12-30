/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import XCTest
@testable import CommonWallet
import Cuckoo
import SoraFoundation


class WithdrawConfirmationTests: NetworkBaseTests {

    func testSetupAndConfirm() {
        do {
            // given

            let accountSettings = try createRandomAccountSettings(for: 1, withdrawOptionsCount: 1)
            let networkResolver = MockNetworkResolver()

            let networkOperationFactory = MiddlewareOperationFactory(accountSettings: accountSettings,
                                                                     networkResolver: networkResolver)

            let view = MockWalletFormViewProtocol()
            let coordinator = MockWithdrawConfirmationCoordinatorProtocol()

            let walletService = WalletService(operationFactory: networkOperationFactory)

            let withdrawInfo = try createRandomWithdrawInfo()

            let eventCenter = WalletEventCenter()

            let withdrawObserver = MockWalletEventVisitorProtocol()

            let presenter = WithdrawConfirmationPresenter(view: view,
                                                          coordinator: coordinator,
                                                          walletService: walletService,
                                                          withdrawInfo: withdrawInfo,
                                                          asset: accountSettings.assets[0],
                                                          withdrawOption: accountSettings.withdrawOptions[0],
                                                          style: WalletStyle(),
                                                          amountFormatter: NumberFormatter().localizableResource(),
                                                          eventCenter: eventCenter)

            // when

            let setupExpectation = XCTestExpectation()
            let confirmExpectation = XCTestExpectation()
            let withdrawEventExpectation = XCTestExpectation()

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
                when(stub).showResult(for: any(WithdrawInfo.self),
                                      asset: any(WalletAsset.self),
                                      option: any(WalletWithdrawOption.self)).then { _ in
                                        confirmExpectation.fulfill()
                }
            }

            stub(withdrawObserver) { stub in
                stub.processWithdrawComplete(event: any()).then { _ in
                    withdrawEventExpectation.fulfill()
                }
            }

            try WithdrawMock.register(mock: .success,
                                      networkResolver: networkResolver,
                                      requestType: .withdraw,
                                      httpMethod: .post)

            eventCenter.add(observer: withdrawObserver, dispatchIn: .main)

            presenter.localizationManager = LocalizationManager(localization: WalletLanguage.english.rawValue)

            presenter.setup()

            // then

            wait(for: [setupExpectation], timeout: Constants.networkTimeout)

            // when

            presenter.performAction()

            // then

            wait(for: [confirmExpectation, withdrawEventExpectation], timeout: Constants.networkTimeout)

        } catch {
            XCTFail("\(error)")
        }
    }
}
