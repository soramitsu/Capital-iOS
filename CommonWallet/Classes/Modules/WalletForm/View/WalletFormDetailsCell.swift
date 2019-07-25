import Foundation

final class WalletFormDetailsCell: UITableViewCell, WalletFormCellProtocol {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var detailsLabel: UILabel!

    var viewModel: WalletFormViewModelProtocol?

    var style: WalletFormCellStyleProtocol? {
        didSet {
            applyStyle()
        }
    }

    func bind(viewModel: WalletFormViewModelProtocol) {
        self.viewModel = viewModel

        titleLabel.text = viewModel.title
        detailsLabel.text = viewModel.details

        applyDetailsColor()
    }

    private func applyStyle() {
        if let style = style {
            titleLabel.textColor = style.title.color
            titleLabel.font = style.title.font
            detailsLabel.textColor = style.details.color
            detailsLabel.font = style.details.font
        }

        applyDetailsColor()
    }

    private func applyDetailsColor() {
        if let style = style, let viewModel = viewModel {
            detailsLabel.textColor = viewModel.detailsColor ?? style.details.color
        }
    }

    static func calculateHeight(for viewModel: WalletFormViewModelProtocol,
                                style: WalletFormCellStyleProtocol,
                                preferredWidth: CGFloat) -> CGFloat {
        let verticalMargin: CGFloat = 20.0
        let horizontalMargin: CGFloat = 20.0
        let verticalSpacing: CGFloat = 10.0

        let cellWidth = preferredWidth - 2 * horizontalMargin

        let preferredTitleSize = CGSize(width: cellWidth, height: 2 * style.title.font.pointSize)
        let titleSize = viewModel.title.calculateSize(with: preferredTitleSize,
                                                      font: style.title.font)

        var detailsSize: CGSize = .zero
        if let details = viewModel.details {
            detailsSize = details.calculateSize(with: CGSize(width: cellWidth, height: .greatestFiniteMagnitude),
                                                font: style.details.font)
        }

        return 2 * verticalMargin + titleSize.height + verticalSpacing + detailsSize.height
    }
}
