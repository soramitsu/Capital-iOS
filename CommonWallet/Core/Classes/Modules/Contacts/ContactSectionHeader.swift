/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import UIKit


final class ContactSectionHeader: UIView {
    
    @IBOutlet private var titleLabel: UILabel!

    private var originalTitle: String?
    
    var style: ContactsSectionStyleProtocol? {
        didSet {
            if let style = style {
                titleLabel.font = style.title.font
                titleLabel.textColor = style.title.color
            }

            setupTitle()
        }
    }
    
    func set(title: String) {
        originalTitle = title
        setupTitle()
    }

    private func setupTitle() {
        if let uppercase = style?.uppercased, uppercase {
            titleLabel.text = originalTitle?.uppercased()
        } else {
            titleLabel.text = originalTitle
        }
    }
}
