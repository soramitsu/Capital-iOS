/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


protocol NavigationProtocol {
    
    var navigationController: WalletNavigationController? { get }
    
    func set(_ viewController: UIViewController, animated: Bool)
    func push(_ controller: UIViewController, animated: Bool)
    func pop(animated: Bool)
    func popToRoot(animated: Bool)
    func dismiss(animated: Bool)
    func present(_ controller: UIViewController, inNavigationController: Bool, animated: Bool)
    
}


extension NavigationProtocol {
    
    func set(_ viewController: UIViewController) {
        set(viewController, animated: true)
    }

    func push(_ controller: UIViewController) {
        push(controller, animated: true)
    }

    func pop() {
        pop(animated: true)
    }

    func popToRoot() {
        popToRoot(animated: true)
    }

    func dismiss() {
        dismiss(animated: true)
    }

    func present(_ controller: UIViewController, inNavigationController: Bool) {
        present(controller, inNavigationController: inNavigationController, animated: true)
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

    private var topViewController: UIViewController? {
        var currentViewController: UIViewController? = navigationController

        while let topViewController = currentViewController?.presentedViewController {
            currentViewController = topViewController
        }

        return currentViewController
    }
    
    init(navigationController: WalletNavigationController, style: WalletStyleProtocol) {
        self.style = style
        self.navigationController = navigationController

        navigationController.navigationBarStyle = style.navigationBarStyle
    }
    
    func set(_ viewController: UIViewController, animated: Bool) {
        activeNavigationController?.setViewControllers([viewController], animated: animated)
    }
    
    func push(_ controller: UIViewController, animated: Bool) {
        activeNavigationController?.pushViewController(controller, animated: animated)
    }
    
    func pop(animated: Bool) {
        activeNavigationController?.popViewController(animated: animated)
    }

    func popToRoot(animated: Bool) {
        activeNavigationController?.popToRootViewController(animated: animated)
    }
    
    func present(_ controller: UIViewController, inNavigationController: Bool, animated: Bool) {
        var presentedController: UIViewController

        if inNavigationController {
            let navigationController = WalletNavigationController(rootViewController: controller)
            navigationController.navigationBarStyle = style.navigationBarStyle
            presentedController = navigationController

            setupCloseButton(into: controller)
        } else {
            presentedController = controller
        }

        topViewController?.present(presentedController, animated: animated, completion: nil)
    }
    
    func dismiss(animated: Bool) {
        if let presentingController = topViewController?.presentingViewController {
            presentingController.dismiss(animated: animated, completion: nil)
        }
    }

    // MARK: Private

    private func setupCloseButton(into viewController: UIViewController) {
        let closeButtonItem = UIBarButtonItem(image: style.closeIcon,
                                              style: .plain,
                                              target: self,
                                              action: #selector(closeModalController))

        viewController.navigationItem.leftBarButtonItem = closeButtonItem
    }

    @objc private func closeModalController() {
        dismiss(animated: true)
    }
}
