/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraUI

class WalletFormDetailsView: WalletFormItemView, WalletFormDetailsViewProtocol {
    private var titleLabel: UILabel = UILabel()
    private var titleIconView: UIImageView?
    private var detailsLabel: UILabel?
    private var detailsIconView: UIImageView?
    private var borderView: BorderedContainerView = BorderedContainerView()

    var style: WalletFormDetailsViewStyle? {
        didSet {
            applyStyle()
            invalidateLayout()
        }
    }

    var borderType: BorderType {
        get {
            borderView.borderType
        }

        set {
            borderView.borderType = newValue
        }
    }

    func bind(viewModel: WalletNewFormDetailsViewModel) {
        titleLabel.text = viewModel.title

        if let titleIcon = viewModel.titleIcon {
            if titleIconView == nil {
                let imageView = UIImageView()
                addSubview(imageView)
                titleIconView = imageView
            }

            titleIconView?.image = titleIcon
        } else if let titleIconView = titleIconView {
            titleIconView.removeFromSuperview()
            self.titleIconView = nil
        }

        if let details = viewModel.details {
            if detailsLabel == nil {
                let label = UILabel()
                label.textColor = style?.details?.color
                label.font = style?.details?.font

                addSubview(label)
                detailsLabel = label
            }

            detailsLabel?.text = details
        } else if let detailsLabel = detailsLabel {
            detailsLabel.removeFromSuperview()
            self.detailsLabel = nil
        }

        if let detailsIcon = viewModel.detailsIcon {
            if detailsIconView == nil {
                let imageView = UIImageView()
                addSubview(imageView)
                detailsIconView = imageView
            }

            detailsIconView?.image = detailsIcon
        } else if let detailsIconView = detailsIconView {
            detailsIconView.removeFromSuperview()
            self.detailsIconView = nil
        }

        invalidateLayout()
    }

    // MARK: Overridings

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .clear

        addSubview(borderView)
        addSubview(titleLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        var intrinsicHeight: CGFloat = titleLabel.intrinsicContentSize.height

        if let titleIconSize = titleIconView?.intrinsicContentSize {
            intrinsicHeight = max(intrinsicHeight, titleIconSize.height)
        }

        if let detailsLabel = detailsLabel {
            intrinsicHeight = max(intrinsicHeight, detailsLabel.intrinsicContentSize.height)
        }

        if let detailsIconSize = detailsIconView?.intrinsicContentSize {
            intrinsicHeight = max(intrinsicHeight, detailsIconSize.height)
        }

        if intrinsicHeight > 0 {
            let contentInsets = style?.contentInsets ?? .zero
            intrinsicHeight += contentInsets.top + contentInsets.bottom
        }

        return CGSize(width: UIView.noIntrinsicMetric, height: intrinsicHeight)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        borderView.frame = CGRect(origin: .zero, size: bounds.size)

        let contentInsets = style?.contentInsets ?? .zero

        var rect = CGRect(x: contentInsets.left,
                          y: contentInsets.top,
                          width: max(bounds.width - contentInsets.left - contentInsets.right, 0.0),
                          height: max(bounds.height - contentInsets.top - contentInsets.bottom, 0.0))

        rect = layoutTitleIconIfNeeded(in: rect)
        rect = applyTitleSpacingIfNeeded(to: rect)
        rect = layoutTitle(in: rect)

        let detailsAlignment = style?.detailsAlignment ?? .detailsIcon

        switch detailsAlignment {
        case .detailsIcon:
            rect = layoutDetailsIconIfNeeded(in: rect)
            rect = applyDetailsSpacingIfNeeded(to: rect)
            rect = layoutDetailsIfNeeded(in: rect)
        case .iconDetails:
            rect = layoutDetailsIfNeeded(in: rect)
            rect = applyDetailsSpacingIfNeeded(to: rect)
            rect = layoutDetailsIconIfNeeded(in: rect)
        }
    }

    private func layoutTitleIconIfNeeded(in rect: CGRect) -> CGRect {
        guard let titleIconView = titleIconView else {
            return rect
        }

        let iconSize = titleIconView.intrinsicContentSize
        titleIconView.frame = CGRect(x: rect.minX,
                                     y: rect.midY - iconSize.height / 2.0,
                                     width: min(iconSize.width, rect.width),
                                     height: iconSize.height)

        return CGRect(x: titleIconView.frame.maxX,
                      y: rect.minY,
                      width: rect.width - iconSize.width,
                      height: rect.height)
    }

    private func layoutTitle(in rect: CGRect) -> CGRect {
        let titleSize = titleLabel.intrinsicContentSize

        titleLabel.frame = CGRect(x: rect.minX,
                                  y: rect.midY - titleSize.height / 2.0,
                                  width: min(titleSize.width, rect.width),
                                  height: titleSize.height)

        return CGRect(x: titleLabel.frame.maxX,
                      y: rect.minY,
                      width: rect.width - titleLabel.frame.width,
                      height: rect.height)
    }

    private func layoutDetailsIfNeeded(in rect: CGRect) -> CGRect {
        guard let detailsLabel = detailsLabel else {
            return rect
        }

        let detailsSize = detailsLabel.intrinsicContentSize
        detailsLabel.frame = CGRect(x: max(rect.minX, rect.maxX - detailsSize.width),
                                    y: rect.midY - detailsSize.height / 2.0,
                                    width: min(detailsSize.width, rect.width),
                                    height: detailsSize.height)

        return CGRect(x: rect.minX,
                      y: rect.minY,
                      width: rect.width - detailsLabel.frame.width,
                      height: rect.height)
    }

    private func layoutDetailsIconIfNeeded(in rect: CGRect) -> CGRect {
        guard let detailsIconView = detailsIconView else {
            return rect
        }

        let iconSize = detailsIconView.intrinsicContentSize
        detailsIconView.frame = CGRect(x: max(rect.minX, rect.maxX - iconSize.width),
                                       y: rect.midY - iconSize.height / 2.0,
                                       width: min(iconSize.width, rect.width),
                                       height: iconSize.height)

        return CGRect(x: rect.minX,
                      y: rect.minY,
                      width: rect.width - detailsIconView.frame.width,
                      height: rect.height)
    }

    private func applyDetailsSpacingIfNeeded(to rect: CGRect) -> CGRect {
        guard detailsLabel != nil, detailsIconView != nil else {
            return rect
        }

        let spacing = style?.detailsHorizontalSpacing ?? 0.0

        return CGRect(x: rect.minX,
                      y: rect.minY,
                      width: max(0.0, rect.width - spacing),
                      height: rect.height)
    }

    private func applyTitleSpacingIfNeeded(to rect: CGRect) -> CGRect {
        guard titleIconView != nil else {
            return rect
        }

        let spacing = style?.titleHorizontalSpacing ?? 0.0

        return CGRect(x: min(rect.minX + spacing, rect.maxX),
                      y: rect.minY,
                      width: max(0.0, rect.width - spacing),
                      height: rect.height)
    }

    // MARK: Private

    private func applyStyle() {
        guard let style = style else {
            return
        }

        borderView.strokeColor = style.separatorStyle.color
        borderView.strokeWidth = style.separatorStyle.lineWidth

        titleLabel.font = style.title.font
        titleLabel.textColor = style.title.color

        detailsLabel?.font = style.details?.font
        detailsLabel?.textColor = style.details?.color
    }

    private func invalidateLayout() {
        invalidateIntrinsicContentSize()

        if superview != nil {
            setNeedsLayout()
        }
    }
}
