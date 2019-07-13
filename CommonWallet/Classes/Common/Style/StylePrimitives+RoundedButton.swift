/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraUI

extension WalletRoundedButtonStyleProtocol {
    func apply(to button: RoundedButton) {
        button.roundedBackgroundView?.fillColor = background
        button.roundedBackgroundView?.highlightedFillColor = background
        button.imageWithTitleView?.titleColor = title.color
        button.imageWithTitleView?.titleFont = title.font

        if let strokeStyle = stroke {
            button.roundedBackgroundView?.strokeColor = strokeStyle.color
            button.roundedBackgroundView?.highlightedStrokeColor = strokeStyle.color
            button.roundedBackgroundView?.strokeWidth = strokeStyle.lineWidth
        }

        if let shadowStyle = shadow {
            button.roundedBackgroundView?.shadowColor = shadowStyle.color
            button.roundedBackgroundView?.shadowOffset = shadowStyle.offset
            button.roundedBackgroundView?.shadowOpacity = shadowStyle.opacity
            button.roundedBackgroundView?.shadowRadius = shadowStyle.blurRadius
        }

        button.changesContentOpacityWhenHighlighted = true
    }
}
