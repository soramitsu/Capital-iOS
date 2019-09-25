/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


protocol NavigationProtocol {
    
    var navigationController: WalletNavigationController? { get }
    
    func set(_ viewController: UIViewController, animated: Bool)
    func push(_ controller: UIViewController)
    func pop()
    func dismiss()
    func present(_ controller: UIViewController, inNavigationController: Bool)
    
}

extension NavigationProtocol {
    func set(_ viewController: UIViewController) {
        set(viewController, animated: false)
    }
}


extension NavigationProtocol {
    
    func present(_ controller: UIViewController) {
        present(controller, inNavigationController: false)
    }
    
}


final class Navigation: NavigationProtocol {
    
    private(set) weak var navigationController: WalletNavigationController?
    private let style: WalletStyleProtocol
    
    private var activeNavigationController: WalletNavigationController? {
        var currentNavigationController = navigationController

        while let topNavigationController = currentNavigationController?
            .presentedViewController as? WalletNavigationController {
            currentNavigationController = topNavigationController
        }

        return currentNavigationController
    }
    
    init(navigationController: WalletNavigationController, style: WalletStyleProtocol) {
        self.style = style
        self.navigationController = navigationController

        navigationController.navigationBarStyle = style.navigationBarStyle
    }
    
    func set(_ viewController: UIViewController, animated: Bool) {
        activeNavigationController?.setViewControllers([viewController], animated: animated)
    }
    
    func push(_ controller: UIViewController) {
        activeNavigationController?.pushViewController(controller, animated: true)
    }
    
    func pop() {
        activeNavigationController?.popViewController(animated: true)
    }
    
    func present(_ controller: UIViewController, inNavigationController: Bool) {
        var presentedController: UIViewController

        if inNavigationController {
            let navigationController = WalletNavigationController(rootViewController: controller)
            navigationController.navigationBarStyle = style.navigationBarStyle
            presentedController = navigationController
        } else {
            presentedController = controller
        }

        activeNavigationController?.present(presentedController, animated: true, completion: nil)
    }
    
    func dismiss() {
        activeNavigationController?.dismiss(animated: true, completion: nil)
    }
    
}
