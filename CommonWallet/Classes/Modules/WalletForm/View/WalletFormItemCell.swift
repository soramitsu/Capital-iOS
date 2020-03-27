/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

final class WalletFormItemCell: UITableViewCell, WalletFormCellProtocol {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var detailsLabel: UILabel!

    var viewModel: WalletFormViewModelProtocol?

    var style: WalletFormCellStyleProtocol? {
        didSet {
            applyStyle()
        }
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)

        detailsLabel.isHighlighted = highlighted
    }

    func bind(viewModel: WalletFormViewModelProtocol) {
        self.viewModel = viewModel

        titleLabel.text = viewModel.title
        iconImageView.image = viewModel.icon

        detailsLabel.text = viewModel.details

        applyDetailsColor()
    }

    private func applyStyle() {
        if let style = style {
            titleLabel.textColor = style.title.color
            titleLabel.font = style.title.font
            detailsLabel.font = style.details.font
        }

        applyDetailsColor()
    }

    private func applyDetailsColor() {
        if let style = style, let viewModel = viewModel {
            if viewModel.command != nil {
                detailsLabel.textColor = style.link.normal
                detailsLabel.highlightedTextColor = style.link.highlighted
            } else {
                let color = viewModel.detailsColor ?? style.details.color
                detailsLabel.textColor = color
                detailsLabel.highlightedTextColor = color
            }
        }
    }

    static func calculateHeight(for viewModel: WalletFormViewModelProtocol,
                                style: WalletFormCellStyleProtocol,
                                preferredWidth: CGFloat) -> CGFloat {
        return 55.0
    }
}
