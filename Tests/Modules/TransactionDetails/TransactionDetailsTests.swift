/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo
import IrohaCommunication
import SoraFoundation


class TransactionDetailsTests: XCTestCase {

    func testSetup() {
        do {
            // given

            let accountSettings = try createRandomAccountSettings(for: 1)

            let view = MockWalletFormViewProtocol()
            let coordinator = MockTransactionDetailsCoordinatorProtocol()

            let resolver = MockResolverProtocol()

            let feeSettingsFactory = FeeDisplaySettingsFactory()

            let configuration = TransactionDetailsConfiguration(sendBackTransactionTypes: [],
                                                                sendAgainTransactionTypes: [],
                                                                fieldActionFactory: WalletFieldActionFactory())

            let localizationManager = LocalizationManager(localization: WalletLanguage.english.rawValue)

            stub(resolver) { stub in
                when(stub).amountFormatterFactory.get.thenReturn(NumberFormatterFactory())
                when(stub).statusDateFormatter.get.thenReturn(DateFormatter().localizableResource())
                when(stub).style.get.thenReturn(WalletStyle())
                when(stub).account.get.thenReturn(accountSettings)
                when(stub).feeDisplaySettingsFactory.get.thenReturn(feeSettingsFactory)
                when(stub).transactionDetailsConfiguration.get.thenReturn(configuration)
                when(stub).localizationManager.get.thenReturn(localizationManager)
            }

            let transactionData = try createRandomAssetTransactionData()
            let assetId = try IRAssetIdFactory.asset(withIdentifier: transactionData.assetId)
            let asset = WalletAsset(identifier: assetId,
                                    symbol: "$",
                                    details: LocalizableResource { _  in "Dollar" },
                                    precision: 2)

            let transactionType: WalletTransactionType

            if transactionData.type == WalletTransactionType.incoming.backendName {
                transactionType = WalletTransactionType.incoming
            } else {
                transactionType = WalletTransactionType.outgoing
            }

            let accessoryViewModelFactory = ContactAccessoryViewModelFactory(style: resolver.style.nameIconStyle,
                                                                             radius: AccessoryView.iconRadius)

            let viewModelFactory = WalletTransactionDetailsFactory(resolver: resolver)

            let presenter = TransactionDetailsPresenter(view: view,
                                                        coordinator: coordinator,
                                                        configuration:  configuration,
                                                        detailsViewModelFactory: viewModelFactory,
                                                        accessoryViewModelFactory: accessoryViewModelFactory,
                                                        transactionData: transactionData,
                                                        transactionType: transactionType,
                                                        asset: asset)

            // when

            let listExpectation = XCTestExpectation()

            stub(view) { stub in
                when(stub).didReceive(viewModels: any()).then { _ in
                    listExpectation.fulfill()
                }

                when(stub).didReceive(accessoryViewModel: any()).thenDoNothing()

                when(stub).isSetup.get.thenReturn(false, true)
            }

            presenter.localizationManager = localizationManager

            presenter.setup()

            // then

            wait(for: [listExpectation], timeout: Constants.networkTimeout)
        } catch {
            XCTFail("\(error)")
        }
    }
}
