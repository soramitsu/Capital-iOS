/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraUI

public typealias BaseSelectedAssetView = UIControl & SelectedAssetViewProtocol

public protocol SelectedAssetViewProtocol: class {
    var delegate: SelectedAssetViewDelegate? { get set }
    var activated: Bool { get }
    var borderType: BorderType { get set }

    func bind(viewModel: AssetSelectionViewModelProtocol)
}

public protocol SelectedAssetViewDelegate: class {
    func selectedAssetViewDidChange(_ view: SelectedAssetViewProtocol)
}

public enum SelectedAssetViewDisplayStyle {
    case singleTitle
    case separatedDetails
}

class SelectedAssetView: BaseSelectedAssetView {
    private(set) var borderedView: BorderedContainerView = BorderedContainerView()
    private(set) var detailsControl: ActionTitleControl = ActionTitleControl()
    private(set) var titleLabel = UILabel()

    private var iconImageView: UIImageView?

    var borderType: BorderType {
        get {
            borderedView.borderType
        }

        set {
            borderedView.borderType = newValue
        }
    }

    var activated: Bool {
        detailsControl.isActivated
    }

    var accessoryIcon: UIImage? {
        didSet {
            applyStyle()
        }
    }

    var contentInsets: UIEdgeInsets = UIEdgeInsets(top: 8.0, left: 0.0, bottom: 8.0, right: 0.0) {
        didSet {
            invalidateLayout()
        }
    }

    var titleHorizontalSpacing: CGFloat = 6.0 {
        didSet {
            invalidateLayout()
        }
    }

    var detailsHorizontalSpacing: CGFloat = 6.0 {
        didSet {
            if detailsControl.imageView.image != nil {
                detailsControl.horizontalSpacing = detailsHorizontalSpacing
                invalidateLayout()
            }
        }
    }

    var displayStyle: SelectedAssetViewDisplayStyle = .singleTitle {
        didSet {
            applyViewModel()
        }
    }

    var titleColor: UIColor = .black {
        didSet {
            applyViewModel()
        }
    }

    var titleFont: UIFont = .systemFont(ofSize: UIFont.labelFontSize) {
        didSet {
            applyViewModel()
        }
    }

    var subtitleColor: UIColor = .gray {
        didSet {
            applyViewModel()
        }
    }

    var subtitleFont: UIFont = .systemFont(ofSize: UIFont.labelFontSize) {
        didSet {
            applyViewModel()
        }
    }

    var opacityValueWhenHighlighted: CGFloat = 0.5

    override var isHighlighted: Bool {
        didSet {
            let canSelect = viewModel?.state.canSelect ?? false
            titleLabel.alpha = isHighlighted && canSelect ? opacityValueWhenHighlighted : 1.0
            iconImageView?.alpha = isHighlighted && canSelect ? opacityValueWhenHighlighted : 1.0
            detailsControl.isHighlighted = isHighlighted && canSelect
        }
    }

    weak var delegate: SelectedAssetViewDelegate?

    private(set) var viewModel: AssetSelectionViewModelProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .clear

        borderedView.isUserInteractionEnabled = false

        addSubview(borderedView)

        addSubview(titleLabel)

        detailsControl.isUserInteractionEnabled = false
        detailsControl.horizontalSpacing = detailsHorizontalSpacing

        addSubview(detailsControl)

        addTarget(self, action: #selector(actionOnTouchUpInside(sender:)), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setActivation(_ value: Bool, animated: Bool) {
        if value {
            detailsControl.activate(animated: animated)
        } else {
            detailsControl.deactivate(animated: animated)
        }
    }

    func bind(viewModel: AssetSelectionViewModelProtocol) {
        self.viewModel = viewModel
        applyViewModel()
    }

    // MARK: Overriding

    override var intrinsicContentSize: CGSize {
        var size = CGSize(width: UIView.noIntrinsicMetric, height: 0.0)

        if let imageView = iconImageView {
            size.height = max(size.height, imageView.intrinsicContentSize.height)
        }

        size.height = max(size.height, titleLabel.intrinsicContentSize.height)
        size.height = max(size.height, detailsControl.intrinsicContentSize.height)

        if size.height > 0.0 {
            size.height += contentInsets.top + contentInsets.bottom
        }

        return size
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        borderedView.frame = CGRect(origin: .zero, size: bounds.size)

        let detailsSize = detailsControl.intrinsicContentSize

        let centerOffset = (contentInsets.top - contentInsets.bottom) / 2.0

        detailsControl.frame = CGRect(x: bounds.width - contentInsets.right - detailsSize.width,
                                      y: bounds.height / 2.0 - detailsSize.height / 2.0 + centerOffset,
                                      width: detailsSize.width,
                                      height: detailsSize.height)

        var leadingOffset: CGFloat = contentInsets.left

        if let iconView = iconImageView {
            let originY = bounds.height / 2.0 - iconView.intrinsicContentSize.height / 2.0 + centerOffset
            let iconSize = iconView.intrinsicContentSize

            iconView.frame = CGRect(x: leadingOffset,
                                    y: originY,
                                    width: iconSize.width,
                                    height: iconSize.height)

            leadingOffset += iconView.frame.maxX + titleHorizontalSpacing
        }

        let titleSize = titleLabel.intrinsicContentSize
        titleLabel.frame = CGRect(x: leadingOffset,
                                  y: bounds.height / 2.0 - titleSize.height / 2.0 + centerOffset,
                                  width: max(0, detailsControl.frame.minX - leadingOffset),
                                  height: titleSize.height)
    }

    // MARK: Private

    private func invalidateLayout() {
        invalidateIntrinsicContentSize()

        if superview != nil {
            setNeedsLayout()
        }
    }

    private func applyViewModel() {
        guard let viewModel = viewModel else {
            return
        }

        switch displayStyle {
        case .singleTitle:
            displaySingleTitle(viewModel.title, subtitle: viewModel.subtitle, details: viewModel.details)
        case .separatedDetails:
            displaySeparatedTitle(viewModel.title, subtitle: viewModel.subtitle, details: viewModel.details)
        }

        if viewModel.state.isSelecting {
            detailsControl.activate(animated: true)
        } else {
            detailsControl.deactivate(animated: true)
        }

        if let newIcon = viewModel.icon {
            if iconImageView == nil {
                let imageView = UIImageView()
                addSubview(imageView)
                self.iconImageView = imageView
            }

            iconImageView?.image = newIcon
        } else {
            if iconImageView != nil {
                iconImageView?.removeFromSuperview()
                iconImageView = nil
            }
        }

        applyStyle()

        invalidateIntrinsicContentSize()
        setNeedsLayout()
    }

    private func displaySingleTitle(_ title: String, subtitle: String, details: String) {
        let mainTitle = [title, subtitle].filter { !$0.isEmpty }.joined(separator: " ")

        titleLabel.textColor = titleColor
        titleLabel.font = titleFont

        titleLabel.text = [mainTitle, details].filter { !$0.isEmpty }.joined(separator: " - ")
        detailsControl.titleLabel.text = ""

        detailsControl.invalidateLayout()
    }

    private func displaySeparatedTitle(_ title: String, subtitle: String, details: String) {
        if !title.isEmpty, !subtitle.isEmpty {
            let titleAttributeString = NSMutableAttributedString(string: "\(title) ",
                                                          attributes: [
                                                            .foregroundColor: titleColor,
                                                            .font: titleFont
            ])

            let subtitleAttributedString = NSAttributedString(string: subtitle,
                                                              attributes: [
                                                                .foregroundColor: subtitleColor,
                                                                .font: subtitleFont
            ])

            titleAttributeString.append(subtitleAttributedString)

            titleLabel.attributedText = titleAttributeString
        } else {
            titleLabel.textColor = titleColor
            titleLabel.font = titleFont

            titleLabel.text = [title, subtitle].filter { !$0.isEmpty }.joined(separator: " ")
        }

        detailsControl.titleLabel.text = details
        detailsControl.invalidateLayout()
    }

    private func applyStyle() {
        if let viewModel = viewModel {
            detailsControl.imageView.image = viewModel.state.canSelect ? accessoryIcon : nil
        } else {
            detailsControl.imageView.image = accessoryIcon
        }

        detailsControl.horizontalSpacing = detailsControl.imageView.image != nil ?
            detailsHorizontalSpacing : 0.0
    }

    @objc private func actionOnTouchUpInside(sender: AnyObject) {
        guard let viewModel = viewModel, viewModel.state.canSelect else {
            return
        }

        if activated {
            detailsControl.deactivate(animated: true)
        } else {
            detailsControl.activate(animated: true)
        }

        delegate?.selectedAssetViewDidChange(self)
    }
}
