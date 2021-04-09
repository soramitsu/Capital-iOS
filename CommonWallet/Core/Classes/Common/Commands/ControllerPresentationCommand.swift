/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

final class ControllerPresentationCommand: WalletPresentationCommandProtocol {
    let resolver: ResolverProtocol
    let controller: UIViewController

    var presentationStyle: WalletPresentationStyle = .modal(inNavigation: false)
    var animated: Bool = true
    var completionBlock: (() -> Void)?

    init(resolver: ResolverProtocol, controller: UIViewController) {
        self.resolver = resolver
        self.controller = controller
    }

    func execute() throws {
        guard let navigation = resolver.navigation else {
            return
        }

        present(view: controller, in: navigation, animated: animated, completion: completionBlock)
    }
}
