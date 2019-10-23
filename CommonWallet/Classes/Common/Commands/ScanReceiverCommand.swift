/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation
import IrohaCommunication

final class ScanReceiverCommand {
    let resolver: ResolverProtocol

    var presentationStyle: WalletPresentationStyle = .push(hidesBottomBar: true)
    var animated: Bool = true

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }
}

extension ScanReceiverCommand: WalletPresentationCommandProtocol {
    func execute() throws {
        guard
            let scanView = InvoiceScanAssembly.assembleView(with: resolver),
            let navigation = resolver.navigation else {
            return
        }

        present(view: scanView.controller, in: navigation, animated: animated)
    }
}
