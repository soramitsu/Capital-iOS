/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

protocol AccessoryViewFactoryProtocol {
    static func createAccessoryView(from style: WalletAccessoryStyleProtocol?,
                                    target: Any?,
                                    completionSelector: Selector?) -> AccessoryViewProtocol
}

final class AccessoryViewFactory: AccessoryViewFactoryProtocol {
    //swiftlint:disable force_cast
    static func createAccessoryView(from style: WalletAccessoryStyleProtocol?,
                                    target: Any?,
                                    completionSelector: Selector?) -> AccessoryViewProtocol {
        let bundle = Bundle(for: self)
        let view = UINib(nibName: "AccessoryView", bundle: bundle)
            .instantiate(withOwner: nil, options: nil).first as! AccessoryView

        if let style = style {
            view.backgroundColor = style.background

            view.borderView.strokeColor = style.separator.color
            view.borderView.strokeWidth = style.separator.lineWidth

            view.titleLabel.textColor = style.title.color
            view.titleLabel.font = style.title.font

            style.action.apply(to: view.actionButton)
        }

        if let target = target, let selector = completionSelector {
            view.actionButton.addTarget(target, action: selector, for: .touchUpInside)
        }

        return view
    }
    //swiftlint:enable force_cast
}
