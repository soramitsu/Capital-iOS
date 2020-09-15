/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraUI

final class CustomPresentationController: UIViewController, ControllerBackedProtocol {
    init(view: UIView, modalPresentationFactory: ModalSheetPresentationFactory) {
        super.init(nibName: nil, bundle: nil)

        self.view = view
        self.modalTransitioningFactory = modalPresentationFactory
        self.preferredContentSize = view.frame.size
        self.modalPresentationStyle = .custom
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
