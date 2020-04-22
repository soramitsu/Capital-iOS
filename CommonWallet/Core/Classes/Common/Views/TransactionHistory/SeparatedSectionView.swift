/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit
import SoraUI

final class SeparatedSectionView: UIView {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var separatorView: BorderedContainerView!

    var style: TransactionHeaderStyleProtocol? {
        didSet {
            applyStyle()
        }
    }

    var title: String? {
        return titleLabel.text
    }

    func bind(title: String) {
        titleLabel.text = title
    }

    private func applyStyle() {
        if let style = style {
            titleLabel.textColor = style.title.color
            titleLabel.font = style.title.font

            separatorView.strokeColor = style.separatorColor
            separatorView.strokeWidth = style.separatorWidth
        }
    }
}
