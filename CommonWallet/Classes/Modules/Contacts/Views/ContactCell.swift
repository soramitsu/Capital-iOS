/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import UIKit


final class ContactCell: UITableViewCell {
    static let avatarRadius: CGFloat = 17.5

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var avatarView: UIImageView!
    @IBOutlet private var accessoryImageView: UIImageView!
    
    private(set) var contactViewModel: ContactViewModelProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarView.contentMode = .scaleAspectFit
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        contactViewModel = nil
    }
    
    private func updateContent() {
        if let contactViewModel = contactViewModel {
            nameLabel.text = contactViewModel.name
            avatarView.image = contactViewModel.image
        }
    }
    
    private func applyStyle() {
        if let contactViewModel = contactViewModel, let style = contactViewModel.style {
            nameLabel.font = style.title.font
            nameLabel.textColor = style.title.color
            accessoryImageView.image = style.accessoryIcon
        }
    }
    
}


extension ContactCell: WalletViewProtocol {
    
    var viewModel: WalletViewModelProtocol? {
        return contactViewModel
    }
    
    func bind(viewModel: WalletViewModelProtocol) {
        guard let contactViewModel = viewModel as? ContactViewModelProtocol else {
            return
        }
        
        self.contactViewModel = contactViewModel
        
        applyStyle()
        updateContent()
    }
    
}
