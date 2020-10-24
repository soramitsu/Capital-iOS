/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol ReceiveStyleProtocol {
    var qrBackgroundColor: UIColor { get }
    var qrSize: CGSize? { get }
}

public struct ReceiveStyle: ReceiveStyleProtocol {
    public let qrBackgroundColor: UIColor
    public let qrSize: CGSize?

    public init(qrBackgroundColor: UIColor, qrSize: CGSize?) {
        self.qrBackgroundColor = qrBackgroundColor
        self.qrSize = qrSize
    }
}

extension ReceiveStyle {
    static func createDefaultStyle(with style: WalletStyleProtocol) -> ReceiveStyle {
        return ReceiveStyle(qrBackgroundColor: .white, qrSize: nil)
    }
}
