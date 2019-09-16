/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import CommonWallet

final class DialogCommandDecorator: WalletCommandDecoratorProtocol {
    var undelyingCommand: WalletCommandProtocol?

    let commandFactory: WalletCommandFactoryProtocol
    let message: String

    init(commandFactory: WalletCommandFactoryProtocol, message: String) {
        self.commandFactory = commandFactory
        self.message = message
    }

    func execute() throws {
        let alertView = UIAlertController(title: "Warning",
                                          message: message,
                                          preferredStyle: .alert)

        let continueAction = UIAlertAction(title: "Continue",
                                           style: .default) { _ in
                                            ((try? self.undelyingCommand?.execute()) as ()??)
        }

        let cancel = UIAlertAction(title: "Cancel",
                                   style: .cancel,
                                   handler: nil)

        alertView.addAction(cancel)
        alertView.addAction(continueAction)

        let presentationCommand = commandFactory.preparePresentationCommand(for: alertView)
        presentationCommand.presentationStyle = .modal(inNavigation: false)

        try presentationCommand.execute()
    }
}
