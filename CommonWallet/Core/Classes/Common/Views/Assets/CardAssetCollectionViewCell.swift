/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraUI

final class CardAssetCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var backgroundRoundedView: RoundedView!
    @IBOutlet private var leftRoundedView: RoundedView!
    @IBOutlet private var symbolLabel: UILabel!
    @IBOutlet private var symbolImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var accessoryLabel: UILabel!

    private(set) var assetViewModel: AssetViewModelProtocol?

    override func prepareForReuse() {
        super.prepareForReuse()

        assetViewModel = nil
    }

    private func applyStyle() {
        if let assetViewModel = assetViewModel {
            switch assetViewModel.style {
            case .card(let style):
                backgroundRoundedView.fillColor = style.backgroundColor
                backgroundRoundedView.cornerRadius = style.cornerRadius
                backgroundRoundedView.shadowColor = style.shadow.color
                backgroundRoundedView.shadowOffset = style.shadow.offset
                backgroundRoundedView.shadowOpacity = style.shadow.opacity
                backgroundRoundedView.shadowRadius = style.shadow.blurRadius
                leftRoundedView.fillColor = style.leftFillColor
                leftRoundedView.cornerRadius = style.cornerRadius
                symbolLabel.textColor = style.symbol.color
                symbolLabel.font = style.symbol.font
                titleLabel.textColor = style.title.color
                titleLabel.font = style.title.font
                subtitleLabel.textColor = style.subtitle.color
                subtitleLabel.font = style.subtitle.font
                accessoryLabel.textColor = style.accessory.color
                accessoryLabel.font = style.accessory.font
            }
        }
    }

    private func applyContent() {
        if let assetViewModel = assetViewModel {
            symbolLabel.isHidden = assetViewModel.imageViewModel != nil
            symbolImageView.isHidden = assetViewModel.imageViewModel == nil

            if let iconViewModel = assetViewModel.imageViewModel {
                iconViewModel.loadImage { [weak self] (icon, _) in
                    self?.symbolImageView.image = icon
                }
            } else {
                symbolLabel.text = assetViewModel.symbol
            }

            titleLabel.text = assetViewModel.amount
            subtitleLabel.text = assetViewModel.details
            accessoryLabel.text = assetViewModel.accessoryDetails
        }
    }

    private func cancelLoading() {
        assetViewModel?.imageViewModel?.cancel()
    }
}

extension CardAssetCollectionViewCell: WalletViewProtocol {
    var viewModel: WalletViewModelProtocol? {
        return assetViewModel
    }

    func bind(viewModel: WalletViewModelProtocol) {
        cancelLoading()

        guard let assetViewModel = viewModel as? AssetViewModelProtocol else {
            return
        }

        self.assetViewModel = assetViewModel

        applyStyle()
        applyContent()
    }
}
