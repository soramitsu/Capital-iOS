/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraUI

final class ActionBarView: UIView {
    @IBOutlet private(set) var actionButton: RoundedButton!
    @IBOutlet private(set) var borderedView: BorderedContainerView!

    private var viewModel: AccessoryViewModelProtocol?
}

extension ActionBarView: AccessoryViewProtocol {
    var contentView: UIView {
        return self
    }

    var isActionEnabled: Bool {
        get {
            actionButton.isEnabled
        }

        set {
            let shouldAllowAction = viewModel?.shouldAllowAction ?? true

            if newValue && shouldAllowAction {
                actionButton.enable()
            } else {
                actionButton.disable()
            }
        }
    }

    func bind(viewModel: AccessoryViewModelProtocol) {
        actionButton.imageWithTitleView?.title = viewModel.action

        if viewModel.shouldAllowAction {
            actionButton.enable()
        } else {
            actionButton.disable()
        }

        actionButton.invalidateLayout()

        self.viewModel = viewModel

        setNeedsLayout()
    }
}
