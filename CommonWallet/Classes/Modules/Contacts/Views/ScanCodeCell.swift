/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraUI

final class ScanCodeCell: UITableViewCell {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var iconView: UIImageView!
    @IBOutlet private var borderView: BorderedContainerView!
    @IBOutlet private var accessoryImageView: UIImageView!
    
    private var scanViewModel: ScanCodeViewModelProtocol?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        scanViewModel = nil
    }
    
    private func updateContent() {
        if let scanViewModel = scanViewModel {
            titleLabel.text = scanViewModel.title
            iconView.image = scanViewModel.icon
        }
    }
    
    private func applyStyle() {
        if let scanViewModel = scanViewModel, let style = scanViewModel.style {
            titleLabel.font = style.title.font
            titleLabel.textColor = style.title.color
            borderView.strokeColor = style.separatorColor
            accessoryImageView.image = style.accessoryIcon
        }
    }
    
}


extension ScanCodeCell: WalletViewProtocol {
    
    var viewModel: WalletViewModelProtocol? {
        return scanViewModel
    }
    
    func bind(viewModel: WalletViewModelProtocol) {
        guard let scanViewModel = viewModel as? ScanCodeViewModelProtocol else {
            return
        }
        
        self.scanViewModel = scanViewModel
        
        applyStyle()
        updateContent()
    }
    
}
