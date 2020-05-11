/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraUI

protocol SelectedAssetViewDelegate: class {
    func selectedAssetViewDidChange(_ view: SelectedAssetView)
}

public enum SelectedAssetViewDisplayStyle {
    case singleTitle
    case separatedDetails
}

final class SelectedAssetView: UIControl {
    private(set) var borderedView: BorderedContainerView = BorderedContainerView()
    private(set) var detailsControl: ActionTitleControl = ActionTitleControl()
    private(set) var titleLabel = UILabel()

    private var iconImageView: UIImageView?

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
            detailsControl.horizontalSpacing = detailsHorizontalSpacing

            invalidateLayout()
        }
    }

    var displayStyle: SelectedAssetViewDisplayStyle = .singleTitle {
        didSet {
            applyViewModel()
        }
    }

    override var isHighlighted: Bool {
        didSet {
            titleLabel.isHighlighted = isHighlighted
            detailsControl.isHighlighted = isHighlighted
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

        let title: String
        let details: String

        switch displayStyle {
        case .singleTitle:
            title = !viewModel.details.isEmpty ? "\(viewModel.title) - \(viewModel.details)" : viewModel.title
            details = ""
        case .separatedDetails:
            title = viewModel.title
            details = viewModel.details
        }

        titleLabel.text = title
        detailsControl.titleLabel.text = details

        if viewModel.isSelecting {
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

        detailsControl.invalidateLayout()

        invalidateIntrinsicContentSize()
        setNeedsLayout()
    }

    private func applyStyle() {
        if let viewModel = viewModel {
            detailsControl.imageView.image = viewModel.canSelect ? accessoryIcon : nil
        } else {
            detailsControl.imageView.image = accessoryIcon
        }
    }

    @objc private func actionOnTouchUpInside(sender: AnyObject) {
        guard let viewModel = viewModel, viewModel.canSelect else {
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
