/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo

class ConfirmationTests: NetworkBaseTests {

    func testSetupAndConfirm() {
        do {
            // given

            let accountSettings = try createRandomAccountSettings(for: 1)
            let networkResolver = MockNetworkResolver()

            let networkOperationFactory = WalletServiceOperationFactory(accountSettings: accountSettings)

            let view = MockWalletFormViewProtocol()
            let coordinator = MockConfirmationCoordinatorProtocol()

            let resolver = MockResolverProtocol()

            let walletService = WalletService(networkResolver: networkResolver,
                                              operationFactory: networkOperationFactory)

            var transferInfo = try createRandomTransferInfo()
            transferInfo.source = accountSettings.accountId

            let transferPayload = TransferPayload(transferInfo: transferInfo,
                                                  receiverName: UUID().uuidString,
                                                  assetSymbol: accountSettings.assets[0].symbol)

            let accessoryViewModelFactory = ContactAccessoryViewModelFactory(style: WalletStyle().nameIconStyle,
                                                                             radius: AccessoryView.iconRadius)

            let presenter = ConfirmationPresenter(view: view,
                                                  coordinator: coordinator,
                                                  service: walletService,
                                                  resolver: resolver,
                                                  payload: transferPayload,
                                                  accessoryViewModelFactory: accessoryViewModelFactory)

            // when

            let setupExpectation = XCTestExpectation()
            let confirmExpectation = XCTestExpectation()

            stub(view) { stub in
                when(stub).didReceive(viewModels: any([WalletFormViewModelProtocol].self)).then { _ in
                    setupExpectation.fulfill()
                }

                when(stub).didReceive(accessoryViewModel: any(AccessoryViewModelProtocol.self)).thenDoNothing()

                when(stub).didStartLoading().thenDoNothing()
                when(stub).didStopLoading().thenDoNothing()
            }

            stub(coordinator) { stub in
                when(stub).showResult(payload: any(TransferPayload.self)).then { _ in
                    confirmExpectation.fulfill()
                }
            }

            stub(resolver) { stub in
                when(stub).amountFormatter.get.thenReturn(NumberFormatter())
                when(stub).statusDateFormatter.get.thenReturn(DateFormatter())
                when(stub).style.get.thenReturn(WalletStyle())
            }

            try TransferMock.register(mock: .success,
                                      networkResolver: networkResolver,
                                      requestType: .transfer,
                                      httpMethod: .post)

            presenter.setup()

            // then

            wait(for: [setupExpectation], timeout: Constants.networkTimeout)

            // when

            presenter.performAction()

            // then

            wait(for: [confirmExpectation], timeout: Constants.networkTimeout)

        } catch {
            XCTFail("\(error)")
        }
    }

}
