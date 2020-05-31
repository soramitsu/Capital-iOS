/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraUI

public enum WalletFormDetailsAlignment {
    case iconDetails
    case detailsIcon
}

public struct WalletFormDetailsViewStyle {
    public let title: WalletTextStyleProtocol
    public let details: WalletTextStyleProtocol?
    public let separatorStyle: WalletStrokeStyleProtocol
    public let contentInsets: UIEdgeInsets
    public let titleHorizontalSpacing: CGFloat
    public let detailsHorizontalSpacing: CGFloat
    public let titleDetailsHorizontalSpacing: CGFloat
    public let detailsAlignment: WalletFormDetailsAlignment

    public init(title: WalletTextStyleProtocol,
                separatorStyle: WalletStrokeStyleProtocol,
                contentInsets: UIEdgeInsets = .zero,
                titleHorizontalSpacing: CGFloat = 0.0,
                detailsHorizontalSpacing: CGFloat = 0.0,
                titleDetailsHorizontalSpacing: CGFloat = 0.0,
                details: WalletTextStyleProtocol? = nil,
                detailsAlignment: WalletFormDetailsAlignment = .iconDetails) {
        self.title = title
        self.details = details
        self.separatorStyle = separatorStyle
        self.contentInsets = contentInsets
        self.titleHorizontalSpacing = titleHorizontalSpacing
        self.detailsHorizontalSpacing = detailsHorizontalSpacing
        self.titleDetailsHorizontalSpacing = titleDetailsHorizontalSpacing
        self.detailsAlignment = detailsAlignment
    }
}

public protocol WalletFormDetailsViewProtocol: class {
    var style: WalletFormDetailsViewStyle? { get set }

    func bind(viewModel: WalletNewFormDetailsViewModel)
}
