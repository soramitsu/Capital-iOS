/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


protocol InvoiceScanMatcherProtocol: WalletQRMatcherProtocol {
    var receiverInfo: ReceiveInfo? { get }
}

final class InvoiceScanMatcher: InvoiceScanMatcherProtocol {
    private(set) var receiverInfo: ReceiveInfo?

    private let decoder: WalletQRDecoderProtocol

    init(decoder: WalletQRDecoderProtocol) {
        self.decoder = decoder
    }

    func match(code: String) -> Bool {
        guard let data = code.data(using: .utf8) else {
            return false
        }

        guard let info = try? decoder.decode(data: data) else {
            return false
        }

        receiverInfo = info

        return true
    }
}
