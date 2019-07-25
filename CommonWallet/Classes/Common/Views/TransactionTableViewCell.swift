/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit

final class TransactionTableViewCell: UITableViewCell {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var amountLabel: UILabel!
    @IBOutlet private var signImageView: UIImageView!
    @IBOutlet private var statusImageView: UIImageView!

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
}
