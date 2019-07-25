/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo
import IrohaCommunication

class TransactionDetailsTests: XCTestCase {

    func testSetup() {
        do {
            // given

            let accountSettings = try createRandomAccountSettings(for: 1)

            let view = MockWalletFormViewProtocol()
            let coordinator = MockTransactionDetailsCoordinatorProtocol()
            let resolver = MockResolverProtocol()

            let transactionData = try createRandomAssetTransactionData()

            let presenter = TransactionDetailsPresenter(view: view,
                                                        coordinator: coordinator,
                                                        resolver: resolver,
                                                        transactionData: transactionData)

            // when
            let expectation = XCTestExpectation()

            stub(view) { stub in
                when(stub).didReceive(viewModels: any()).then { _ in
                    expectation.fulfill()
                }
            }

            stub(resolver) { stub in
                when(stub).amountFormatter.get.thenReturn(NumberFormatter())
                when(stub).statusDateFormatter.get.thenReturn(DateFormatter())
                when(stub).style.get.thenReturn(WalletStyle())
                when(stub).account.get.thenReturn(accountSettings)
            }

            presenter.setup()

            // then

            wait(for: [expectation], timeout: Constants.networkTimeout)
        } catch {
            XCTFail("\(error)")
        }
    }
}
