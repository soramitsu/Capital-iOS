/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraUI

public protocol HistoryBackgroundViewProtocol {
    func applyFullscreen(progress: CGFloat)
    func apply(style: HistoryViewStyleProtocol)
}

public typealias BaseHistoryBackgroundView = HistoryBackgroundViewProtocol & UIView

final class HistoryBackgroundView: RoundedView {
    private var minimizedCornerRadius: CGFloat = 0.0
}

extension HistoryBackgroundView: HistoryBackgroundViewProtocol {
    func apply(style: HistoryViewStyleProtocol) {
        shadowOpacity = 0.0
        fillColor = style.fillColor
        highlightedFillColor = style.fillColor
        cornerRadius = style.cornerRadius
        strokeColor = style.borderStyle.color
        highlightedStrokeColor = style.borderStyle.color
        strokeWidth = style.borderStyle.lineWidth

        minimizedCornerRadius = cornerRadius
    }

    func applyFullscreen(progress: CGFloat) {
        cornerRadius = minimizedCornerRadius * progress
    }
}
