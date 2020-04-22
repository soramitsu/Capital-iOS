/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit

typealias SharingCompletionHandler = (Bool) -> Void

protocol SharingPresentable {
    func share(sources: [Any],
               from view: ControllerBackedProtocol?,
               with completionHandler: SharingCompletionHandler?)
}

extension SharingPresentable {
    func share(sources: [Any],
               from view: ControllerBackedProtocol?,
               with completionHandler: SharingCompletionHandler?) {
        var currentController = view?.controller

        if currentController == nil {
            currentController = UIApplication.shared.delegate?.window??.rootViewController
        }

        guard let controller = currentController else {
            return
        }

        let activityController = UIActivityViewController(activityItems: sources,
                                                          applicationActivities: nil)

        if let handler = completionHandler {
            activityController.completionWithItemsHandler = { (alertType, completed, returnedItems, error) in
                handler(completed)
            }
        }

        controller.present(activityController, animated: true, completion: nil)
    }
}
