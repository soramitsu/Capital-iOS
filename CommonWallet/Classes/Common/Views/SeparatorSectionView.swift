/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraUI

final class SeparatorSectionView: UIView {
    @IBOutlet private var separatorView: BorderedContainerView!

    var style: WalletStrokeStyleProtocol? {
        didSet {
            applyStyle()
        }
    }

    private func applyStyle() {
        if let style = style {
            separatorView.strokeColor = style.color
            separatorView.strokeWidth = style.lineWidth
        }
    }
}
