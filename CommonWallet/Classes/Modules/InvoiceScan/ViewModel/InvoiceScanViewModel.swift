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

    private lazy var decoder = JSONDecoder()

    func match(code: String) -> Bool {
        guard let data = code.data(using: .utf8) else {
            return false
        }

        guard let info = try? decoder.decode(ReceiveInfo.self, from: data) else {
            return false
        }

        receiverInfo = info

        return true
    }
}
