/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import XCTest
@testable import CommonWallet
import Cuckoo
import SoraFoundation


class WithdrawResultTests: NetworkBaseTests {

    func testSetup() {
        do {
            // given

            let view = MockWalletFormViewProtocol()
            let coordinator = MockWithdrawResultCoordinatorProtocol()

            let accountSettings = try createRandomAccountSettings(for: 1, withdrawOptionsCount: 1)

            let withdrawInfo = try createRandomWithdrawInfo()

            let presenter = WithdrawResultPresenter(view: view,
                                                    coordinator: coordinator,
                                                    withdrawInfo: withdrawInfo,
                                                    asset: accountSettings.assets[0],
                                                    withdrawOption: accountSettings.withdrawOptions[0],
                                                    style: WalletStyle(),
                                                    amountFormatter: NumberFormatter().localizableResource(),
                                                    dateFormatter: DateFormatter().localizableResource(),
                                                    feeDisplaySettings: FeeDisplaySettings.defaultSettings)

            // when

            let mainExpectation = XCTestExpectation()
            let accessoryExpectation = XCTestExpectation()

            stub(view) { stub in
                when(stub).didReceive(viewModels: any()).then { _ in
                    mainExpectation.fulfill()
                }

                when(stub).didReceive(accessoryViewModel: any(AccessoryViewModelProtocol?.self)).then { _ in
                    accessoryExpectation.fulfill()
                }

                when(stub).isSetup.get.thenReturn(false, true)
            }

            let completionExpectation = XCTestExpectation()

            stub(coordinator) { stub in
                when(stub).dismiss().then {
                    completionExpectation.fulfill()
                }
            }

            presenter.localizationManager = LocalizationManager(localization: WalletLanguage.english.rawValue)

            presenter.setup()

            // then

            wait(for: [mainExpectation, accessoryExpectation], timeout: Constants.networkTimeout)

            // when

            presenter.performAction()

            wait(for: [completionExpectation], timeout: Constants.networkTimeout)

        } catch {
            XCTFail("\(error)")
        }
    }
}
