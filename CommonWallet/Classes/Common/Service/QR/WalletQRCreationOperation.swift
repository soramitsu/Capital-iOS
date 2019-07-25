/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import CoreImage
import RobinHood

enum WalletQRCreationOperationError: Error {
    case generatorUnavailable
    case generatedImageInvalid
}

final class WalletQRCreationOperation: BaseOperation<UIImage> {
    let payload: Data
    let qrSize: CGSize

    init(payload: Data, qrSize: CGSize) {
        self.payload = payload
        self.qrSize = qrSize

        super.init()
    }

    override public func main() {
        super.main()

        guard let filter = CIFilter(name: "CIQRCodeGenerator") else {
            if !isCancelled {
                result = .error(WalletQRCreationOperationError.generatorUnavailable)
            }

            return
        }

        filter.setValue(payload, forKey: "inputMessage")
        filter.setValue("M", forKey: "inputCorrectionLevel")

        guard let qrImage = filter.outputImage else {
            if !isCancelled {
                result = .error(WalletQRCreationOperationError.generatedImageInvalid)
            }

            return
        }

        let resultImage: CIImage

        if qrImage.extent.size.width * qrImage.extent.height > 0.0 {
            let transform = CGAffineTransform(scaleX: qrSize.width / qrImage.extent.width,
                                              y: qrSize.height / qrImage.extent.height)
            resultImage = qrImage.transformed(by: transform)
        } else {
            resultImage = qrImage
        }


        if !isCancelled {
            result = .success(UIImage(ciImage: resultImage))
        }
    }
}
