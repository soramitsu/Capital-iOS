/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraUI

final class ActionBarView: UIView {
    @IBOutlet private(set) var actionButton: RoundedButton!
    @IBOutlet private(set) var borderedView: BorderedContainerView!
}

extension ActionBarView: AccessoryViewProtocol {
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
        actionButton.imageWithTitleView?.title = viewModel.action
        actionButton.invalidateLayout()

        setNeedsLayout()
    }
}
