/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo
import SoraFoundation


class TransactionDetailsTests: XCTestCase {

    func testSetup() {
        do {
            // given

            let view = MockWalletNewFormViewProtocol()
            let coordinator = MockTransactionDetailsCoordinatorProtocol()

            let style = WalletStyle()

            let feeSettingsFactory = FeeDisplaySettingsFactory()

            let transactionData = try createRandomAssetTransactionData()
            let asset = WalletAsset(identifier: transactionData.assetId,
                                    name: LocalizableResource { _ in "Dollar" },
                                    platform: LocalizableResource { _ in "USA"},
                                    symbol: "$",
                                    precision: 2)

            let transactionType: WalletTransactionType

            if transactionData.type == WalletTransactionType.incoming.backendName {
                transactionType = WalletTransactionType.incoming
            } else {
                transactionType = WalletTransactionType.outgoing
            }

            let amountFormatterFactory = NumberFormatterFactory()

            let statusFormatter = DateFormatter().localizableResource()

            let viewModelFactory = WalletTransactionDetailsFactory(transactionTypes: [transactionType],
                                                                   assets: [asset],
                                                                   feeDisplayFactory: feeSettingsFactory,
                                                                   generatingIconStyle: style.nameIconStyle,
                                                                   amountFormatterFactory: amountFormatterFactory,
                                                                   localizableDataFormatter: statusFormatter,
                                                                   sendBackTypes: [transactionType.backendName],
                                                                   sendAgainTypes: [transactionType.backendName])

            let commandFactory = createMockedCommandFactory()
            let presenter = TransactionDetailsPresenter(view: view,
                                                        coordinator: coordinator,
                                                        transactionData: transactionData,
                                                        detailsViewModelFactory: viewModelFactory,
                                                        commandFactory: commandFactory)

            // when

            let listExpectation = XCTestExpectation()

            stub(view) { stub in
                when(stub).didReceive(viewModels: any()).then { _ in
                    listExpectation.fulfill()
                }

                when(stub).didReceive(accessoryViewModel: any()).thenDoNothing()

                when(stub).didStartLoading().thenDoNothing()
                when(stub).didStopLoading().thenDoNothing()
                when(stub).isSetup.get.thenReturn(false, true)
            }

            presenter.localizationManager = LocalizationManager(localization: WalletLanguage.english.rawValue)

            presenter.setup()

            // then

            wait(for: [listExpectation], timeout: Constants.networkTimeout)
        } catch {
            XCTFail("\(error)")
        }
    }
}
