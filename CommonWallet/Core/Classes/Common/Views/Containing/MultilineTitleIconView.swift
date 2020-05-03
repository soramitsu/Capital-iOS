/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import UIKit

class MultilineTitleIconView: UIView {
    private(set) var titleLabel: UILabel = UILabel()

    private var imageView: UIImageView?

    private var viewModel: MultilineTitleIconViewModelProtocol?

    private var preferredWidth: CGFloat = 0.0

    var horizontalSpacing: CGFloat = 6.0 {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        }
    }


    var contentInsets: UIEdgeInsets = .zero {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        }
    }

    func bind(viewModel: MultilineTitleIconViewModelProtocol) {
        self.viewModel = viewModel

        titleLabel.text = viewModel.text

        if let icon = viewModel.icon {
            if imageView == nil {
                let imageView = UIImageView()
                addSubview(imageView)
                self.imageView = imageView
            }

            imageView?.image = icon
        } else {
            if imageView != nil {
                imageView?.removeFromSuperview()
                imageView = nil
            }
        }

        setNeedsLayout()
    }

    // MARK: Overridings

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .clear

        titleLabel.numberOfLines = 0
        addSubview(titleLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        guard preferredWidth > 0.0 else {
            return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
        }

        var resultSize = CGSize(width: UIView.noIntrinsicMetric, height: 0.0)

        if let imageView = imageView {
            resultSize.height = imageView.intrinsicContentSize.height
        }

        let boundingWidth = max(preferredWidth - contentInsets.left - contentInsets.right, 0.0)
        let boundingSize = CGSize(width: boundingWidth, height: CGFloat.greatestFiniteMagnitude)
        let titleSize = titleLabel.sizeThatFits(boundingSize)

        resultSize.height = max(resultSize.height, titleSize.height)

        if resultSize.height > 0.0 {
            resultSize.height += contentInsets.top + contentInsets.bottom
        }

        return resultSize
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        var horizontalOffset = contentInsets.left

        let inset = (contentInsets.top - contentInsets.bottom) / 2.0

        if let imageView = imageView {
            let imageSize = imageView.image?.size ?? .zero
            imageView.frame = CGRect(x: horizontalOffset,
                                     y: bounds.height / 2.0 - imageSize.height / 2.0 + inset,
                                     width: imageSize.width,
                                     height: imageSize.height)
            horizontalOffset += imageSize.width + horizontalSpacing
        }

        let titleSize = titleLabel.intrinsicContentSize
        titleLabel.frame = CGRect(x: horizontalOffset,
                                  y: bounds.height / 2.0 - titleSize.height / 2.0 + inset,
                                  width: bounds.width - horizontalOffset - contentInsets.right,
                                  height: titleSize.height)

        if abs(bounds.width - preferredWidth) > CGFloat.leastNormalMagnitude {
            preferredWidth = bounds.width
            invalidateIntrinsicContentSize()
        }
    }
}
