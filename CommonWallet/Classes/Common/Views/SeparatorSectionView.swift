import Foundation
import SoraUI

final class SeparatorSectionView: UIView {
    @IBOutlet private var separatorView: BorderedContainerView!

    var style: WalletStrokeStyleProtocol? {
        didSet {
            applyStyle()
        }
    }

    private func applyStyle() {
        if let style = style {
            separatorView.strokeColor = style.color
            separatorView.strokeWidth = style.lineWidth
        }
    }
}
