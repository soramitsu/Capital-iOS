/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public struct WalletFormTokenViewStyle {
    public let title: WalletTextStyleProtocol
    public let subtitle: WalletTextStyleProtocol
    public let contentInset: UIEdgeInsets
    public let iconTitleSpacing: CGFloat
    public let separatorStyle: WalletStrokeStyleProtocol

    public init(title: WalletTextStyleProtocol,
                subtitle: WalletTextStyleProtocol,
                contentInset: UIEdgeInsets,
                iconTitleSpacing: CGFloat,
                separatorStyle: WalletStrokeStyleProtocol) {
        self.title = title
        self.subtitle = subtitle
        self.contentInset = contentInset
        self.iconTitleSpacing = iconTitleSpacing
        self.separatorStyle = separatorStyle
    }
}

public protocol WalletFormTokenViewProtocol: class {
    var style: WalletFormTokenViewStyle? { get set }

    func bind(viewModel: WalletFormTokenViewModel)
}
