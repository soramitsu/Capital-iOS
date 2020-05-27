/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo
import SoraFoundation


class ReceiveAmountTests: XCTestCase {

    func testSetup() {
        do {
            let view = MockReceiveAmountViewProtocol()
            let coordinator = MockReceiveAmountCoordinatorProtocol()
            let accountSettings = try createRandomAccountSettings(for: 1)

            try performSetup(for: view,
                             coordinator: coordinator,
                             accountSettings: accountSettings)
        } catch {
            XCTFail("Failed with \(error)")
        }
    }

    func testSharing() {
        do {

            // given

            let view = MockReceiveAmountViewProtocol()
            let coordinator = MockReceiveAmountCoordinatorProtocol()
            let accountSettings = try createRandomAccountSettings(for: 1)

            let presenter = try performSetup(for: view,
                                             coordinator: coordinator,
                                             accountSettings: accountSettings)

            // when

            let expectation = XCTestExpectation()

            stub(coordinator) { stub in
                when(stub).share(sources: any(), from: any(), with: any()).then { _ in
                    expectation.fulfill()
                }
            }

            presenter.share()

            // then

            wait(for: [expectation], timeout: Constants.networkTimeout)

        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }

    // MARK: Private

    @discardableResult
    private func performSetup(for view: MockReceiveAmountViewProtocol,
                              coordinator: MockReceiveAmountCoordinatorProtocol,
                              accountSettings: WalletAccountSettingsProtocol) throws -> ReceiveAmountPresenter {
        // given

        let receiveInfo = ReceiveInfo(accountId: accountSettings.accountId,
                                      assetId: accountSettings.assets[0].identifier,
                                      amount: nil,
                                      details: nil)
        let qrService = WalletQRService(operationFactory: WalletQROperationFactory())

        // when

        let imageExpectation = XCTestExpectation()
        let assetExpectation = XCTestExpectation()
        let amountExpectation = XCTestExpectation()
        let descriptionExpectation = XCTestExpectation()

        stub(view) { stub in
            when(stub).didReceive(assetSelectionViewModel: any(AssetSelectionViewModelProtocol.self)).then { _ in
                assetExpectation.fulfill()
            }

            when(stub).didReceive(amountInputViewModel: any(AmountInputViewModelProtocol.self)).then { _ in
                amountExpectation.fulfill()
            }

            when(stub).didReceive(image: any(UIImage.self)).then { _ in
                imageExpectation.fulfill()
            }

            when(stub).didReceive(descriptionViewModel: any(DescriptionInputViewModelProtocol.self)).then { _ in
                descriptionExpectation.fulfill()
            }

            when(stub).isSetup.get.thenReturn(false, true)
        }

        let amountFormatterFactory = NumberFormatterFactory()
        let settings = WalletTransactionSettings.defaultSettings
        let descriptionFactory = WalletInputValidatorFactoryDecorator(descriptionMaxLength: 64)

        let viewModelFactory = ReceiveViewModelFactory(amountFormatterFactory: amountFormatterFactory,
                                                       descriptionValidatorFactory: descriptionFactory,
                                                       transactionSettings: settings)

        let localizationManager = LocalizationManager(localization: WalletLanguage.english.rawValue)
        let presenter = try ReceiveAmountPresenter(view: view,
                                                   coordinator: coordinator,
                                                   assets: accountSettings.assets,
                                                   accountId: accountSettings.accountId,
                                                   qrService: qrService,
                                                   sharingFactory: AccountShareFactory(),
                                                   receiveInfo: receiveInfo,
                                                   viewModelFactory: viewModelFactory,
                                                   shouldIncludeDescription: true,
                                                   localizationManager: localizationManager)

        presenter.setup(qrSize: CGSize(width: 100.0, height: 100.0))

        // then

        wait(for: [imageExpectation, assetExpectation, amountExpectation, descriptionExpectation],
             timeout: Constants.networkTimeout)

        return presenter
    }
}
