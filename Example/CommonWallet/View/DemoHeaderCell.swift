/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit
import CommonWallet

final class DemoHeaderCell: UICollectionViewCell {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var closeButton: UIButton!

    private(set) var headerViewModel: DemoHeaderViewModelProtocol?

    override func prepareForReuse() {
        super.prepareForReuse()

        headerViewModel = nil
    }

    @IBAction private func actionClose() {
        if let headerViewModel = headerViewModel {
            headerViewModel.delegate?.didSelectClose(for: headerViewModel)
        }
    }
}

extension DemoHeaderCell: WalletViewProtocol {

    func bind(viewModel: WalletViewModelProtocol) {
        if let headerViewModel = viewModel as? DemoHeaderViewModelProtocol {
            self.headerViewModel = headerViewModel

            titleLabel.text = headerViewModel.title
            titleLabel.textColor = headerViewModel.style.color
            titleLabel.font = headerViewModel.style.font
            closeButton.imageView?.tintColor = headerViewModel.style.color
        }
    }
}
