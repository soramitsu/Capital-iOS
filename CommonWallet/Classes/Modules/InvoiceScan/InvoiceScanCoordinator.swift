/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


final class InvoiceScanCoordinator: InvoiceScanCoordinatorProtocol {
    let resolver: ResolverProtocol

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }

    func process(payload: AmountPayload) {
        guard let view = AmountAssembly.assembleView(with: resolver, payload: payload) else {
            return
        }

        resolver.navigation.push(view.controller)
    }
}
