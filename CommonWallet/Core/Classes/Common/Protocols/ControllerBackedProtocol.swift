/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

protocol ControllerBackedProtocol: class {
    var isSetup: Bool { get }
    var controller: UIViewController { get }
}

extension ControllerBackedProtocol where Self: UIViewController {
    var isSetup: Bool {
        return controller.isViewLoaded
    }

    var controller: UIViewController {
        return self
    }
}
