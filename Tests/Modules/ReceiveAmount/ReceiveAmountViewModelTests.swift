/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import XCTest
@testable import CommonWallet
import Cuckoo
import SoraFoundation

class ReceiveAmountViewModelTests: XCTestCase {

    func testAssetViewModelForSingleAsset() throws {
        // given

        let view = MockReceiveAmountViewProtocol()

        let account = try createRandomAccountSettings(for: 1)

        let presenter = try createPresenter(for: view, accountSettings: account)

        // when

        let expectation = XCTestExpectation()

        stub(view) { stub in
            when(stub).didReceive(assetSelectionViewModel: any()).then { viewModel in
                XCTAssertFalse(viewModel.canSelect)
                expectation.fulfill()
            }
        }

        presenter.setup(qrSize: CGSize(width: 100.0, height: 100.0))

        // then

        wait(for: [expectation], timeout: Constants.networkTimeout)
    }

    func testAssetViewModelForSeveralAsset() throws {
        // given

        let view = MockReceiveAmountViewProtocol()

        let account = try createRandomAccountSettings(for: 2)

        let presenter = try createPresenter(for: view, accountSettings: account)

        // when

        let expectation = XCTestExpectation()

        stub(view) { stub in
            when(stub).didReceive(assetSelectionViewModel: any()).then { viewModel in
                XCTAssertTrue(viewModel.canSelect)
                expectation.fulfill()
            }
        }

        presenter.setup(qrSize: CGSize(width: 100.0, height: 100.0))

        // then

        wait(for: [expectation], timeout: Constants.networkTimeout)
    }

    // MARK: Private

    private func createPresenter(for view: MockReceiveAmountViewProtocol,
                                 accountSettings: WalletAccountSettingsProtocol)
        throws -> ReceiveAmountPresenterProtocol {

        let receiveInfo = ReceiveInfo(accountId: accountSettings.accountId,
                                      assetId: accountSettings.assets[0].identifier,
                                      amount: nil,
                                      details: nil)
        let qrService = WalletQRService(operationFactory: WalletQROperationFactory())

        let assetSelectionFactory = AssetSelectionFactory(amountFormatterFactory: NumberFormatterFactory())

        let coordinator = MockReceiveAmountCoordinatorProtocol()

        stub(view) { stub in
            when(stub).didReceive(assetSelectionViewModel: any()).thenDoNothing()

            when(stub).didReceive(amountInputViewModel: any()).thenDoNothing()

            when(stub).didReceive(image: any()).thenDoNothing()

            when(stub).didReceive(descriptionViewModel: any()).thenDoNothing()

            when(stub).isSetup.get.thenReturn(false, true)
        }

        let amountFormatterFactory = NumberFormatterFactory()
        let transactionFactory = WalletTransactionSettingsFactory()
        let descriptionFactory = WalletInputValidatorFactoryDecorator(descriptionMaxLength: 64)

        let viewModelFactory = ReceiveViewModelFactory(amountFormatterFactory: amountFormatterFactory,
                                                       descriptionValidatorFactory: descriptionFactory,
                                                       transactionSettingsFactory: transactionFactory)

        let localizationManager = LocalizationManager(localization: WalletLanguage.english.rawValue)
        let presenter = try ReceiveAmountPresenter(view: view,
                                                   coordinator: coordinator,
                                                   account: accountSettings,
                                                   assetSelectionFactory: assetSelectionFactory,
                                                   qrService: qrService,
                                                   sharingFactory: AccountShareFactory(),
                                                   receiveInfo: receiveInfo,
                                                   viewModelFactory: viewModelFactory,
                                                   shouldIncludeDescription: true,
                                                   localizationManager: localizationManager)

        return presenter
    }
}
