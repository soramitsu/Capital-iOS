import UIKit
import SoraUI

final class DefaultEmptyStateDataSource {
    var titleForEmptyState: String?
    var imageForEmptyState: UIImage?
    var titleColorForEmptyState: UIColor? = UIColor(white: 137.0 / 255.0, alpha: 1.0)
    var titleFontForEmptyState: UIFont? = UIFont(name: "HelveticaNeue", size: 12.0)
    var verticalSpacingForEmptyState: CGFloat? = 16.0
    var trimStrategyForEmptyState: EmptyStateView.TrimStrategy = .none

    init(title: String, image: UIImage? = nil) {
        self.titleForEmptyState = title
        self.imageForEmptyState = image
    }
}

extension DefaultEmptyStateDataSource: EmptyStateDataSource {
    var viewForEmptyState: UIView? {
        return nil
    }
}
