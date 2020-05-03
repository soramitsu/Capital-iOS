/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import UIKit

class MultilineTitleIconView: UIView {
    private(set) var titleLabel: UILabel = UILabel()

    private var imageView: UIImageView?

    private var viewModel: MultilineTitleIconViewModelProtocol?

    var horizontalSpacing: CGFloat = 6.0 {
        didSet {
            setNeedsLayout()
        }
    }


    var contentInsets: UIEdgeInsets = .zero {
        didSet {
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

    private func calculateSizeFitting(_ targetSize: CGSize) -> CGSize {
        var resultSize = CGSize(width: targetSize.width, height: 0.0)

        if let imageView = imageView {
            resultSize.height = imageView.intrinsicContentSize.height
        }

        let boundingWidth = max(targetSize.width - contentInsets.left - contentInsets.right, 0.0)
        let boundingSize = CGSize(width: boundingWidth, height: CGFloat.greatestFiniteMagnitude)
        let titleSize = titleLabel.sizeThatFits(boundingSize)

        resultSize.height = min(max(resultSize.height, titleSize.height), targetSize.height)

        return resultSize
    }

    // MARK: Overridings

    override init(frame: CGRect) {
        super.init(frame: frame)

        titleLabel.numberOfLines = 0

        addSubview(titleLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        calculateSizeFitting(targetSize)
    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize,
                                          withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
                                          verticalFittingPriority: UILayoutPriority) -> CGSize {
        calculateSizeFitting(targetSize)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        var horizontalOffset = contentInsets.left

        if let imageView = imageView {
            let imageSize = imageView.image?.size ?? .zero
            imageView.frame = CGRect(x: horizontalOffset,
                                     y: bounds.height / 2.0 - imageSize.height / 2.0,
                                     width: imageSize.width,
                                     height: imageSize.height)
            horizontalOffset += imageSize.width + horizontalSpacing
        }

        let titleSize = titleLabel.intrinsicContentSize
        titleLabel.frame = CGRect(x: horizontalOffset,
                                  y: bounds.height / 2.0 - titleSize.height / 2.0,
                                  width: bounds.width - horizontalOffset - contentInsets.right,
                                  height: titleSize.height)
    }
}
