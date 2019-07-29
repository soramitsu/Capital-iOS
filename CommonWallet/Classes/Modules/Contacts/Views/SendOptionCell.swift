/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraUI

final class SendOptionCell: UITableViewCell {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var iconView: UIImageView!
    @IBOutlet private var borderView: BorderedContainerView!
    @IBOutlet private var accessoryImageView: UIImageView!
    
    private var sendOptionViewModel: SendOptionViewModelProtocol?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        sendOptionViewModel = nil
    }
    
    private func updateContent() {
        titleLabel.text = sendOptionViewModel?.title
        iconView.image = sendOptionViewModel?.icon
    }
    
    private func applyStyle() {
        if let style = sendOptionViewModel?.style {
            titleLabel.font = style.title.font
            titleLabel.textColor = style.title.color
            borderView.strokeColor = .clear
            accessoryImageView.image = style.accessoryIcon
        }
    }
    
}


extension SendOptionCell: WalletViewProtocol {
    
    var viewModel: WalletViewModelProtocol? {
        return sendOptionViewModel
    }
    
    func bind(viewModel: WalletViewModelProtocol) {
        guard let sendOptionViewModel = viewModel as? SendOptionViewModel else {
            return
        }
        
        self.sendOptionViewModel = sendOptionViewModel
        
        applyStyle()
        updateContent()
    }
    
}
