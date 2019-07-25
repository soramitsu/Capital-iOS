/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo
import IrohaCommunication

class AmountTests: NetworkBaseTests {

    func testSetup() {
        do {
            // given

            let assetId = try IRAssetIdFactory.asset(withIdentifier: Constants.soraAssetId)
            let walletAsset = WalletAsset(identifier: assetId, symbol: "A", details: UUID().uuidString)
            let accountSettings = try createRandomAccountSettings(for: [walletAsset])

            let networkResolver = MockWalletNetworkResolverProtocol()

            let cacheFacade = CoreDataTestCacheFacade()

            let networkOperationFactory = WalletServiceOperationFactory(accountSettings: accountSettings)

            let dataProviderFactory = DataProviderFactory(networkResolver: networkResolver,
                                                          accountSettings: accountSettings,
                                                          cacheFacade: cacheFacade,
                                                          networkOperationFactory: networkOperationFactory)
            let dataProvider = try dataProviderFactory.createBalanceDataProvider()

            let assetSelectionFactory = AssetSelectionFactory(amountFormatter: NumberFormatter())
            let accessoryViewModelFactory = ContactAccessoryViewModelFactory(style: WalletStyle().nameIconStyle,
                                                                             radius: AccessoryView.iconRadius)

            let view = MockAmountViewProtocol()
            let coordinator = MockAmountCoordinatorProtocol()

            let assetSelectionObserver = MockAssetSelectionViewModelObserver()

            // when

            let assetExpectation = XCTestExpectation()
            let amountExpectation = XCTestExpectation()
            let descriptionExpectation = XCTestExpectation()
            let accessoryExpectation = XCTestExpectation()

            let balanceExpectation = XCTestExpectation()

            stub(view) { stub in
                when(stub).set(assetViewModel: any()).then { assetViewModel in
                    assetViewModel.observable.add(observer: assetSelectionObserver)

                    assetExpectation.fulfill()
                }

                when(stub).set(amountViewModel: any()).then { _ in
                    amountExpectation.fulfill()
                }

                when(stub).set(descriptionViewModel: any()).then { _ in
                    descriptionExpectation.fulfill()
                }

                when(stub).set(accessoryViewModel: any()).then { _ in
                    accessoryExpectation.fulfill()
                }
            }

            stub(networkResolver) { stub in
                when(stub).urlTemplate(for: any(WalletRequestType.self)).thenReturn(Constants.balanceUrlTemplate)
                when(stub).adapter(for: any(WalletRequestType.self)).thenReturn(nil)
            }

            stub(assetSelectionObserver) { stub in
                when(stub).assetSelectionDidChangeTitle().then { title in
                    balanceExpectation.fulfill()
                }
            }

            try FetchBalanceMock.register(mock: .success,
                                          networkResolver: networkResolver,
                                          requestType: .balance,
                                          httpMethod: .post)

            let recieverInfo = try createRandomReceiveInfo()
            let amountPayload = AmountPayload(receiveInfo: recieverInfo, receiverName: UUID().uuidString)

            let presenter = AmountPresenter(view: view,
                                            coordinator: coordinator,
                                            balanceDataProvider: dataProvider,
                                            account: accountSettings,
                                            payload: amountPayload,
                                            assetSelectionFactory: assetSelectionFactory,
                                            accessoryFactory: accessoryViewModelFactory,
                                            amountLimit: 100.0,
                                            descriptionMaxLength: 64)

            presenter.setup()

            // then

            wait(for: [assetExpectation, amountExpectation, descriptionExpectation, balanceExpectation, accessoryExpectation], timeout: Constants.networkTimeout)

        } catch {
            XCTFail("\(error)")
        }
    }
}
