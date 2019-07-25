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

    func testZeroQrSizeGeneration() {
        guard let info = try? createRandomReceiveInfo() else {
            XCTFail()
            return
        }

        performTestQrCodeGeneration(for: info, qrSize: .zero)
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
                                        XCTFail()
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
}
