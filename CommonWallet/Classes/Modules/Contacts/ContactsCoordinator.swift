/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


final class ContactsCoordinator: ContactsCoordinatorProtocol {
    
    private let resolver: ResolverProtocol
    
    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }
    
    func send(to payload: AmountPayload) {
        guard let amountView = AmountAssembly.assembleView(with: resolver,
                                                           payload: payload) else {
            return
        }
        
        resolver.navigation?.push(amountView.controller)
    }

    func scanInvoice() {
        guard let scanView = InvoiceScanAssembly.assembleView(with: resolver) else {
            return
        }

        resolver.navigation?.push(scanView.controller)
    }
}
