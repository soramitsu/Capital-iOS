/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public struct WalletFormTitleIconViewStyle {
    public let title: WalletTextStyleProtocol
    public let separatorStyle: WalletStrokeStyleProtocol
    public let contentInsets: UIEdgeInsets
    public let horizontalSpacing: CGFloat

    public init(title: WalletTextStyleProtocol,
                separatorStyle: WalletStrokeStyleProtocol,
                contentInsets: UIEdgeInsets,
                horizontalSpacing: CGFloat) {
        self.title = title
        self.separatorStyle = separatorStyle
        self.contentInsets = contentInsets
        self.horizontalSpacing = horizontalSpacing
    }
}

public protocol WalletFormTitleIconViewProtocol: class {
    var style: WalletFormTitleIconViewStyle? { get set }

    func bind(viewModel: MultilineTitleIconViewModelProtocol)
}
