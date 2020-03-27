/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraUI

final class FeeView: UIView {
    @IBOutlet private(set) var titleLabel: UILabel!
    @IBOutlet private(set) var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private(set) var borderedView: BorderedContainerView!

    private(set) var viewModel: FeeViewModelProtocol?

    var contentInsets = UIEdgeInsets.zero {
        didSet {
            if superview != nil {
                invalidateIntrinsicContentSize()
            }
        }
    }

    override var intrinsicContentSize: CGSize {
        let height = contentInsets.top + contentInsets.bottom +
            max(titleLabel.intrinsicContentSize.height, activityIndicator.intrinsicContentSize.height)
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }

    func bind(viewModel: FeeViewModelProtocol) {
        self.viewModel?.observable.remove(observer: self)

        self.viewModel = viewModel

        viewModel.observable.add(observer: self)

        titleLabel.text = viewModel.title

        if viewModel.isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}

extension FeeView: FeeViewModelObserver {
    func feeTitleDidChange() {
        titleLabel.text = viewModel?.title
    }

    func feeLoadingStateDidChange() {
        guard let viewModel = viewModel else {
            return
        }

        if viewModel.isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}
