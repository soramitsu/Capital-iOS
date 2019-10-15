/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet

class WalletQRServiceTests: XCTestCase {

    func testNormalQrGeneration() {
        guard let info = try? createRandomReceiveInfo() else {
            XCTFail()
            return
        }

        performTestQrCodeGeneration(for: info, qrSize: CGSize(width: 100.0, height: 100.0))
    }

    func testSmallQrGeneration() {
        guard let info = try? createRandomReceiveInfo() else {
            XCTFail()
            return
        }

        performTestQrCodeGeneration(for: info, qrSize: CGSize(width: 1.0, height: 1.0))
    }

    func testZeroQrSizeGeneration() {
        guard let info = try? createRandomReceiveInfo() else {
            XCTFail()
            return
        }

        performTestQrFailure(for: info, qrSize: .zero) { error in
            if let operationError = error as? WalletQRCreationOperationError {
                return operationError == .bitmapImageCreationFailed
            } else {
                return false
            }
        }
    }

    func testQrCodeGenerationCancel() {
        do {
            let service = WalletQRService(operationFactory: WalletQROperationFactory())

            let expectation = XCTestExpectation()

            let receiveInfo = try createRandomReceiveInfo()

            let qrSize = CGSize(width: 100.0, height: 100.0)

            let operation = try service.generate(from: receiveInfo,
                                 qrSize: qrSize,
                                 runIn: .main) { (optionalResult) in
                                    defer {
                                        expectation.fulfill()
                                    }

                                    XCTAssertNil(optionalResult)
            }

            operation.cancel()

            wait(for: [expectation], timeout: Constants.networkTimeout)
        } catch {
            XCTFail("Failed with \(error)")
        }
    }

    private func performTestQrCodeGeneration(for info: ReceiveInfo, qrSize: CGSize) {
        do {
            let service = WalletQRService(operationFactory: WalletQROperationFactory())

            let expectation = XCTestExpectation()

            var qrImage: UIImage?

            try service.generate(from: info,
                                 qrSize: qrSize,
                                 runIn: .main) { (optionalResult) in
                                    defer {
                                        expectation.fulfill()
                                    }

                                    guard let result = optionalResult, case .success(let image) = result else {
                                        XCTFail("Unexpected result")
                                        return
                                    }

                                    qrImage = image
            }

            wait(for: [expectation], timeout: Constants.networkTimeout)

            XCTAssertEqual(qrSize, qrImage?.size)
            XCTAssertEqual(qrImage?.scale, 1.0)
        } catch {
            XCTFail("Failed with \(error)")
        }
    }

    private func performTestQrFailure(for info: ReceiveInfo, qrSize: CGSize, errorCheckBlock: @escaping (Error) -> Bool) {
        do {
            let service = WalletQRService(operationFactory: WalletQROperationFactory())

            let expectation = XCTestExpectation()

            var optionalReceivedError: Error?

            try service.generate(from: info,
                                 qrSize: qrSize,
                                 runIn: .main) { (optionalResult) in
                                    defer {
                                        expectation.fulfill()
                                    }

                                    guard let result = optionalResult, case .failure(let error) = result else {
                                        XCTFail()
                                        return
                                    }

                                    optionalReceivedError = error
            }

            wait(for: [expectation], timeout: Constants.networkTimeout)

            guard let receivedError = optionalReceivedError else {
                XCTFail("Unexpected empty error")
                return
            }

            XCTAssert(errorCheckBlock(receivedError))
        } catch {
            XCTFail("Failed with \(error)")
        }
    }
}
