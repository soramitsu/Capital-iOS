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

    private var originalTitle: String?

    var title: String? {
        return titleLabel.text
    }

    func bind(title: String) {
        self.originalTitle = title

        applyUppercased()
    }

    private func applyStyle() {
        if let style = style {
            backgroundColor = style.background

            titleLabel.textColor = style.title.color
            titleLabel.font = style.title.font

            separatorView.strokeColor = style.separatorColor
            separatorView.strokeWidth = style.separatorWidth

            applyUppercased()
        }
    }

    private func applyUppercased() {
        if let style = style, style.upppercased {
            titleLabel.text = originalTitle?.uppercased()
        } else {
            titleLabel.text = originalTitle
        }
    }
}
