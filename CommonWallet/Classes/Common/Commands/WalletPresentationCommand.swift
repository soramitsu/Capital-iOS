/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation

public enum WalletPresentationStyle {
    case push(hidesBottomBar: Bool)
    case modal(inNavigation: Bool)
}

public protocol WalletPresentationCommandProtocol: WalletCommandProtocol {
    var presentationStyle: WalletPresentationStyle { get set }
}

extension WalletPresentationCommandProtocol {
    func present(view: UIViewController, in navigation: NavigationProtocol) {
        switch presentationStyle {
        case .push(let hidesBottomBar):
            view.hidesBottomBarWhenPushed = hidesBottomBar
            navigation.push(view)
        case .modal(let inNavigation):
            navigation.present(view, inNavigationController: inNavigation)
        }
    }
}
