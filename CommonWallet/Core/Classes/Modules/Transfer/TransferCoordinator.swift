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
        guard let confirmationView = TransferConfirmationAssembly.assembleView(with: resolver,
                                                                               payload: payload) else {
            return
        }
        
        resolver.navigation?.push(confirmationView.controller)
    }
}
