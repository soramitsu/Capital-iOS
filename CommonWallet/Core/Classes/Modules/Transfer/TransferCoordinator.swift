/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

final class TransferCoordinator: TransferCoordinatorProtocol {
    
    let resolver: ResolverProtocol
    
    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }
    
    func confirm(with payload: ConfirmationPayload) {
        let command = TransferConfirmationCommand(payload: payload,
                                                  resolver: resolver)

        if let decorator = resolver.commandDecoratorFactory?
            .createTransferConfirmationDecorator(with: resolver.commandFactory, payload: payload) {
            decorator.undelyingCommand = command

            try? decorator.execute()
        } else {
            try? command.execute()
        }
    }
}
