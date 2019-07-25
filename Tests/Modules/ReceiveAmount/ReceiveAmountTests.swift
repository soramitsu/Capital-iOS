import XCTest
@testable import CommonWallet
import Cuckoo

class ReceiveAmountTests: XCTestCase {

    func testSetup() {
        do {

            // given

            let view = MockReceiveAmountViewProtocol()
            let coordinator = MockReceiveAmountCoordinatorProtocol()

            let accountSettings = try createRandomAccountSettings(for: 1)
            let receiveInfo = ReceiveInfo(accountId: accountSettings.accountId,
                                          assetId: accountSettings.assets[0].identifier,
                                          amount: nil,
                                          details: nil)
            let qrService = WalletQRService(operationFactory: WalletQROperationFactory())

            let assetSelectionFactory = AssetSelectionFactory(amountFormatter: NumberFormatter())

            // when

            let presenter = ReceiveAmountPresenter(view: view,
                                                 coordinator: coordinator,
                                                 account: accountSettings,
                                                 assetSelectionFactory: assetSelectionFactory,
                                                 qrService: qrService,
                                                 receiveInfo: receiveInfo,
                                                 amountLimit: Decimal(1e+6))

            let imageExpectation = XCTestExpectation()
            let assetExpectation = XCTestExpectation()
            let amountExpectation = XCTestExpectation()

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
            }

            presenter.setup(qrSize: CGSize(width: 100.0, height: 100.0))

            // then

            wait(for: [imageExpectation, assetExpectation, amountExpectation], timeout: Constants.networkTimeout)

        } catch {
            XCTFail("Failed with \(error)")
        }
    }

}
