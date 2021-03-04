/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit
import SoraUI

final class DefaultEmptyStateDataSource: EmptyStateDataSource {
    let viewForEmptyState: UIView? = nil
    let titleForEmptyState: String?
    let imageForEmptyState: UIImage?
    let titleColorForEmptyState: UIColor? = UIColor(white: 137.0 / 255.0, alpha: 1.0)
    let titleFontForEmptyState: UIFont? = UIFont(name: "HelveticaNeue", size: 12.0)
    let verticalSpacingForEmptyState: CGFloat? = 16.0
    let trimStrategyForEmptyState = EmptyStateView.TrimStrategy.none

    init(title: String, image: UIImage? = nil) {
        self.titleForEmptyState = title
        self.imageForEmptyState = image
    }
}
