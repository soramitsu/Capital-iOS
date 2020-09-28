/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraUI

public protocol AccessoryViewProtocol: class {
    var contentView: UIView { get }

    var isActionEnabled: Bool { get set }

    var extendsUnderSafeArea: Bool { get }

    func bind(viewModel: AccessoryViewModelProtocol)
}

public extension AccessoryViewProtocol {
    var extendsUnderSafeArea: Bool { false }
}

final class AccessoryView: UIView {

    private struct Constants {
        static let titleLeadingWithIcon: CGFloat = 45.0
        static let titleLeadingWithoutIcon: CGFloat = 0.0
    }

    @IBOutlet private(set) var borderView: BorderedContainerView!
    @IBOutlet private(set) var iconImageView: UIImageView!
    @IBOutlet private(set) var titleLabel: UILabel!
    @IBOutlet private var titleLeading: NSLayoutConstraint!
    @IBOutlet private(set) var actionButton: RoundedButton!

    private var viewModel: AccessoryViewModelProtocol?
}

extension AccessoryView: AccessoryViewProtocol {
    var contentView: UIView {
        return self
    }

    var isActionEnabled: Bool {
        set {
            if newValue {
                actionButton.enable()
            } else {
                actionButton.disable()
            }
        }

        get {
            actionButton.isEnabled
        }
    }

    func bind(viewModel: AccessoryViewModelProtocol) {
        iconImageView.image = viewModel.icon
        iconImageView.isHidden = (viewModel.icon == nil)

        titleLabel.text = viewModel.title
        titleLeading.constant = iconImageView.isHidden ? Constants.titleLeadingWithoutIcon
            : Constants.titleLeadingWithIcon
        titleLabel.numberOfLines = viewModel.numberOfLines

        actionButton.imageWithTitleView?.title = viewModel.action
        actionButton.invalidateLayout()

        self.viewModel = viewModel

        setNeedsLayout()
    }
}
