/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo
import IrohaCommunication
import AVFoundation

class InvoiceScanTests: NetworkBaseTests {

    func testSuccessfullProcessing() {
        do {
            let accountId = try IRAccountIdFactory.account(withIdentifier: Constants.invoiceAccountId)
            let assetId = try IRAssetIdFactory.asset(withIdentifier: Constants.soraAssetId)
            let receiverInfo = ReceiveInfo(accountId: accountId, assetId: assetId, amount: nil, details: nil)
            let receiverData = try JSONEncoder().encode(receiverInfo)
            let receiverDataString = String(data: receiverData, encoding: .utf8)!

            performProcessingTest(for: receiverDataString, shouldMatch: true, networkMock: .invoice, expectsSuccess: true)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testUnknownReceiverProcessing() {
        do {
            let receiverInfo = try createRandomReceiveInfo()
            let receiverData = try JSONEncoder().encode(receiverInfo)
            let receiverDataString = String(data: receiverData, encoding: .utf8)!

            performProcessingTest(for: receiverDataString, shouldMatch: true, networkMock: .invoice, expectsSuccess: false)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testBrokenQrCode() {
        performProcessingTest(for: UUID().uuidString, shouldMatch: false, networkMock: .invoice, expectsSuccess: false)
    }

    // MARK: Private

    private func performProcessingTest(for code: String, shouldMatch: Bool, networkMock: SearchMock, expectsSuccess: Bool) {
        do {
            // given

            let accountSettings = try createRandomAccountSettings(for: 1)
            let networkResolver = MockNetworkResolver()
            let networkOperationFactory = MiddlewareOperationFactory(accountSettings: accountSettings,
                                                                     networkResolver: networkResolver)
            let networkService = WalletService(operationFactory: networkOperationFactory)

            let view = MockInvoiceScanViewProtocol()
            let coordinator = MockInvoiceScanCoordinatorProtocol()

            let qrScanServiceFactory = MockWalletQRCaptureServiceFactoryProtocol()
            let qrScanService = MockWalletQRCaptureServiceProtocol()

            // when

            let setupExpectation = XCTestExpectation()
            let completionExpectation = XCTestExpectation()

            stub(view) { stub in
                when(stub).didReceive(session: any(AVCaptureSession.self)).then { _ in
                    setupExpectation.fulfill()
                }

                when(stub).present(message: any(String.self), animated: any(Bool.self)).then { _ in
                    completionExpectation.fulfill()
                }
            }

            stub(coordinator) { stub in
                when(stub).process(payload: any(AmountPayload.self)).then { _ in
                    completionExpectation.fulfill()
                }
            }

            try SearchMock.register(mock: networkMock,
                                    networkResolver: networkResolver,
                                    requestType: .search,
                                    httpMethod: .get,
                                    urlMockType: .regex)

            var qrMatcher: WalletQRMatcherProtocol?

            stub(qrScanServiceFactory) { (stub) in
                when(stub).createService(with: any(), delegate: any(), delegateQueue: any()).then { (matcher, _, _) in
                    qrMatcher = matcher
                    return qrScanService
                }
            }

            stub(qrScanService) { (stub) in
                when(stub).delegate.set(any()).thenDoNothing()

                when(stub).stop().thenDoNothing()
            }

            let presenter = InvoiceScanPresenter(view: view,
                                                 coordinator: coordinator,
                                                 currentAccountId: accountSettings.accountId,
                                                 networkService: networkService,
                                                 qrScanServiceFactory: qrScanServiceFactory,
                                                 qrCoderFactory: WalletQRCoderFactory())

            stub(qrScanService) { (stub) in
                when(stub).start().then {
                    presenter.qrCapture(service: qrScanService, didSetup: AVCaptureSession())
                }
            }

            // then

            presenter.prepareAppearance()
            presenter.handleDismiss()

            wait(for: [setupExpectation], timeout: Constants.networkTimeout)

            guard case .active = presenter.scanState else {
                XCTFail()
                return
            }

            guard let isMatched = qrMatcher?.match(code: code), isMatched == shouldMatch else {
                XCTFail()
                return
            }

            if shouldMatch {
                presenter.qrCapture(service: qrScanService, didMatch: code)
            } else {
                presenter.qrCapture(service: qrScanService, didFailMatching: code)
            }

            wait(for: [completionExpectation], timeout: Constants.networkTimeout)

            guard case .active = presenter.scanState else {
                XCTFail()
                return
            }

            if expectsSuccess {
                verify(coordinator, times(1)).process(payload: any(AmountPayload.self))
            } else {
                verify(view, times(1)).present(message: any(String.self), animated: any(Bool.self))
            }

        } catch {
            XCTFail("\(error)")
        }
    }
}
