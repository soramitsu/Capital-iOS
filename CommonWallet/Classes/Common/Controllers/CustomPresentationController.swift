/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraUI

final class CustomPresentationController: UIViewController, ControllerBackedProtocol {
    private(set) var modalPresentationFactory: ModalInputPresentationFactory?

    init(view: UIView, modalPresentationFactory: ModalInputPresentationFactory) {
        self.modalPresentationFactory = modalPresentationFactory

        super.init(nibName: nil, bundle: nil)

        self.view = view
        self.transitioningDelegate = modalPresentationFactory
        self.modalPresentationStyle = .custom
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
