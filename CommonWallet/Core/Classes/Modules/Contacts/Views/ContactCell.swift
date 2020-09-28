/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import UIKit


final class ContactCell: UITableViewCell, ContactsCellStylable {
    static let avatarRadius: CGFloat = 17.5

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var avatarView: UIImageView!
    @IBOutlet private var accessoryImageView: UIImageView!
    
    private(set) var contactViewModel: ContactViewModelProtocol?

    var style: ContactsCellStyle? {
        didSet {
            applyStyle()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarView.contentMode = .scaleAspectFit
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        contactViewModel = nil
    }

    private func applyStyle() {
        if let style = style?.contactStyle {
            nameLabel.font = style.title.font
            nameLabel.textColor = style.title.color
            nameLabel.lineBreakMode = style.lineBreakMode
            accessoryImageView.image = style.accessoryIcon

            if let selectionColor = style.selectionColor {
                let selectionView = UIView()
                selectionView.backgroundColor = selectionColor
                self.selectedBackgroundView = selectionView
            } else {
                self.selectedBackgroundView = nil
            }
        }
    }
    
    private func updateContent() {
        if let contactViewModel = contactViewModel {
            nameLabel.text = contactViewModel.name
            avatarView.image = contactViewModel.image
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

        updateContent()
    }
    
}
