/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

extension UIControl {
    func disable(with alpha: CGFloat = 0.5) {
        self.isEnabled = false
        self.alpha = alpha
    }

    func enable() {
        self.isEnabled = true
        self.alpha = 1.0
    }
}
