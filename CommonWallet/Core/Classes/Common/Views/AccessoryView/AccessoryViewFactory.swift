/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol AccessoryViewFactoryProtocol {
    static func createAccessoryView(from type: WalletAccessoryViewType,
                                    style: WalletAccessoryStyleProtocol?,
                                    target: Any?,
                                    completionSelector: Selector?) -> AccessoryViewProtocol
}

final class AccessoryViewFactory: AccessoryViewFactoryProtocol {
    static func createAccessoryView(from type: WalletAccessoryViewType,
                                    style: WalletAccessoryStyleProtocol?,
                                    target: Any?,
                                    completionSelector: Selector?) -> AccessoryViewProtocol {
        switch type {
        case .titleIconActionBar:
            return createAccessoryView(from: style,
                                       target: target,
                                       completionSelector: completionSelector)
        case .onlyActionBar:
            return createActionBarView(from: style,
                                       target: target,
                                       completionSelector: completionSelector)
        }
    }

    //swiftlint:disable force_cast
    private static func createActionBarView(from style: WalletAccessoryStyleProtocol?,
                                            target: Any?,
                                            completionSelector: Selector?) -> AccessoryViewProtocol {
        let bundle = Bundle(for: self)
        let view = UINib(nibName: "ActionBarView", bundle: bundle)
            .instantiate(withOwner: nil, options: nil).first as! ActionBarView

        if let style = style {
            view.backgroundColor = style.background

            view.borderedView.strokeColor = style.separator.color
            view.borderedView.strokeWidth = style.separator.lineWidth

            style.action.apply(to: view.actionButton)
        }

        if let target = target, let selector = completionSelector {
            view.actionButton.addTarget(target, action: selector, for: .touchUpInside)
        }

        return view
    }
    //swiftlint:enable force_cast

    //swiftlint:disable force_cast
    private static func createAccessoryView(from style: WalletAccessoryStyleProtocol?,
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
