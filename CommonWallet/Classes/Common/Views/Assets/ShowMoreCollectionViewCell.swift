/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraUI

final class ShowMoreCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var showMoreActionTitle: ActionTitleControl!

    private(set) var showMoreViewModel: ShowMoreViewModelProtocol?

    override func prepareForReuse() {
        super.prepareForReuse()

        showMoreViewModel?.observable.remove(observer: self)
        showMoreViewModel = nil
    }

    private func changeExpanding(value: Bool, animated: Bool) {
        if value {
            showMoreActionTitle.titleLabel.text = showMoreViewModel?.expandedTitle
            showMoreActionTitle.invalidateLayout()

            showMoreActionTitle.activate(animated: animated)
        } else {
            showMoreActionTitle.titleLabel.text = showMoreViewModel?.collapsedTitle
            showMoreActionTitle.invalidateLayout()

            showMoreActionTitle.deactivate(animated: animated)
        }
    }
}

extension ShowMoreCollectionViewCell: WalletViewProtocol {
    var viewModel: WalletViewModelProtocol? {
        return showMoreViewModel
    }

    func bind(viewModel: WalletViewModelProtocol) {
        if let showMoreViewModel = viewModel as? ShowMoreViewModelProtocol {
            self.showMoreViewModel = showMoreViewModel

            if showMoreViewModel.expanded {
                showMoreActionTitle.titleLabel.text = showMoreViewModel.expandedTitle
            } else {
                showMoreActionTitle.titleLabel.text = showMoreViewModel.collapsedTitle
            }

            showMoreActionTitle.titleLabel.textColor = showMoreViewModel.style.color
            showMoreActionTitle.titleLabel.font = showMoreViewModel.style.font
            showMoreActionTitle.imageView.tintColor = showMoreViewModel.style.color

            changeExpanding(value: showMoreViewModel.expanded, animated: false)

            showMoreViewModel.observable.add(observer: self)
        }
    }
}

extension ShowMoreCollectionViewCell: ShowMoreViewModelObserver {
    func didChangeExpanded(oldValue: Bool) {
        changeExpanding(value: !oldValue, animated: true)
    }
}
