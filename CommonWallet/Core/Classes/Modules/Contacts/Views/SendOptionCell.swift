/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraUI

final class SendOptionCell: UITableViewCell, ContactsCellStylable {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var iconView: UIImageView!
    @IBOutlet private var borderView: BorderedContainerView!
    @IBOutlet private var accessoryImageView: UIImageView!
    
    private var sendOptionViewModel: SendOptionViewModelProtocol?

    var style: ContactsCellStyle? {
        didSet {
            applyStyle()
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        sendOptionViewModel = nil
    }

    private func applyStyle() {
        if let style = style?.sendOptionStyle {
            titleLabel.font = style.title.font
            titleLabel.textColor = style.title.color
            borderView.strokeColor = .clear
            accessoryImageView.image = style.accessoryIcon
        }
    }
    
    private func updateContent() {
        titleLabel.text = sendOptionViewModel?.title
        iconView.image = sendOptionViewModel?.icon
    }
}


extension SendOptionCell: WalletViewProtocol {
    
    var viewModel: WalletViewModelProtocol? {
        return sendOptionViewModel
    }
    
    func bind(viewModel: WalletViewModelProtocol) {
        guard let sendOptionViewModel = viewModel as? SendOptionViewModelProtocol else {
            return
        }
        
        self.sendOptionViewModel = sendOptionViewModel
        
        updateContent()
    }
    
}
