/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit

final class TransactionTableViewCell: UITableViewCell {
    private struct Constants {
        static let leadingEmptyImage: CGFloat = 20.0
        static let leadingNonEmptyImage: CGFloat = 10.0
    }

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var amountLabel: UILabel!
    @IBOutlet private var signImageView: UIImageView!
    @IBOutlet private var statusImageView: UIImageView!
    @IBOutlet private var titleLeading: NSLayoutConstraint!
    private var iconImageView: UIImageView?

    private(set) var viewModel: TransactionItemViewModelProtocol?

    var statusStyleProvider: TransactionStatusDesignable? {
        didSet {
            applyStyle()
        }
    }

    var style: TransactionCellStyleProtocol? {
        didSet {
            applyStyle()
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        viewModel = nil
    }

    func bind(viewModel: TransactionItemViewModelProtocol) {
        self.viewModel = viewModel

        applyViewModel()
    }

    private func applyViewModel() {
        if let viewModel = viewModel {
            titleLabel.text = viewModel.title
            amountLabel.text = viewModel.amount

            apply(icon: viewModel.icon)
            applyIncomingIcon()
            applyStatusStyle()
        }
    }

    private func applyIncomingIcon() {
        if let viewModel = viewModel {
            if viewModel.incoming, let icon = style?.increaseAmountIcon {
                signImageView.image = icon
            }

            if !viewModel.incoming, let icon = style?.decreaseAmountIcon {
                signImageView.image = icon
            }
        }
    }

    private func applyStatusStyle() {
        if let viewModel = viewModel, let style = style, let statusStyleProvider = statusStyleProvider {
            amountLabel.textColor = statusStyleProvider.fetchColor(for: viewModel.status,
                                                                   incoming: viewModel.incoming,
                                                                   style: style)

            statusImageView.image = statusStyleProvider.fetchIcon(for: viewModel.status,
                                                                  incoming: viewModel.incoming,
                                                                  style: style)
        }
    }

    private func applyStyle() {
        if let style = style {
            backgroundColor = style.backgroundColor

            titleLabel.textColor = style.title.color
            titleLabel.font = style.title.font

            amountLabel.font = style.amount.font

            applyIncomingIcon()
            applyStatusStyle()
        }
    }

    private func apply(icon: UIImage?) {
        if let icon = icon {
            if iconImageView == nil {
                let iconImageView = UIImageView()
                iconImageView.translatesAutoresizingMaskIntoConstraints = false

                contentView.addSubview(iconImageView)

                let leading = iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                                     constant: Constants.leadingNonEmptyImage)
                leading.isActive = true

                let center = iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
                center.isActive = true

                self.iconImageView = iconImageView
            }

            titleLeading.constant = icon.size.width + 2 * Constants.leadingNonEmptyImage

            iconImageView?.image = icon
        } else {
            iconImageView?.removeFromSuperview()
            iconImageView = nil

            titleLeading.constant = Constants.leadingEmptyImage
        }

        var currentInsets = self.separatorInset
        currentInsets.left = titleLeading.constant
        self.separatorInset = currentInsets
    }
}
