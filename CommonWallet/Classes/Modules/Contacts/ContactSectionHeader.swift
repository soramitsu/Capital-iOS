/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import UIKit


final class ContactSectionHeader: UIView {
    
    @IBOutlet private var titleLabel: UILabel!
    
    var style: WalletTextStyleProtocol? {
        didSet {
            if let style = style {
                titleLabel.font = style.font
                titleLabel.textColor = style.color
            }
        }
    }
    
    func set(title: String) {
        titleLabel.text = title
    }
    
}
