/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import UIKit

protocol AlertPresentable: class {
    func showAlert(title: String,
                   message: String,
                   actions: [(String, UIAlertAction.Style)],
                   completion: @escaping (_ index: Int) -> Void)
}

extension AlertPresentable {

    func showError(message: String) {
        showAlert(title: "Error",
                  message: message,
                  actions: [("Close", .cancel)],
                  completion: { _ in })
    }
}

extension AlertPresentable where Self: ControllerBackedProtocol {
    func showAlert(title: String,
                   message: String,
                   actions: [(String, UIAlertAction.Style)],
                   completion: @escaping (_ index: Int) -> Void) {

        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, (title, style)) in actions.enumerated() {
            let alertAction = UIAlertAction(title: title, style: style) { (_) in
                completion(index)
            }
            alertViewController.addAction(alertAction)
        }

        controller.present(alertViewController, animated: true, completion: nil)
    }
}
