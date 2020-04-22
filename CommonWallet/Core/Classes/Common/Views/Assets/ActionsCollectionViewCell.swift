/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraUI

final class ActionsCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var sendButton: RoundedButton!
    @IBOutlet private var receiveButton: RoundedButton!
    @IBOutlet private var separatorView: UIView!

    private(set) var actionsViewModel: ActionsViewModelProtocol?

    override func prepareForReuse() {
        super.prepareForReuse()

        actionsViewModel = nil
    }

    @IBAction private func actionSend() {
        if let actionsViewModel = actionsViewModel {
            try? actionsViewModel.send.command.execute()
        }
    }

    @IBAction private func actionReceive() {
        if let actionsViewModel = actionsViewModel {
            try? actionsViewModel.receive.command.execute()
        }
    }
}

extension ActionsCollectionViewCell: WalletViewProtocol {
    var viewModel: WalletViewModelProtocol? {
        return actionsViewModel
    }

    func bind(viewModel: WalletViewModelProtocol) {
        if let actionsViewModel = viewModel as? ActionsViewModelProtocol {
            self.actionsViewModel = actionsViewModel

            sendButton.imageWithTitleView?.title = actionsViewModel.send.title
            receiveButton.imageWithTitleView?.title = actionsViewModel.receive.title
            sendButton.imageWithTitleView?.titleColor = actionsViewModel.send.style.color
            sendButton.imageWithTitleView?.titleFont = actionsViewModel.send.style.font
            receiveButton.imageWithTitleView?.titleColor = actionsViewModel.receive.style.color
            receiveButton.imageWithTitleView?.titleFont = actionsViewModel.receive.style.font

            sendButton.invalidateLayout()
            receiveButton.invalidateLayout()
        }
    }
}
