/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraUI

final class QRView: UIView {
    @IBOutlet private(set) var borderedView: BorderedContainerView!
    @IBOutlet private(set) var imageView: UIImageView!
    @IBOutlet private var top: NSLayoutConstraint!
    @IBOutlet private var bottom: NSLayoutConstraint!

    var margin: CGFloat {
        get {
            top.constant
        }

        set {
            top.constant = newValue
            bottom.constant = -newValue

            if superview != nil {
                setNeedsLayout()
            }
        }
    }
}
