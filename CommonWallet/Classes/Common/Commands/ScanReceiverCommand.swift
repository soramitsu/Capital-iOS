/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation
import IrohaCommunication

final class ScanReceiverCommand {
    let resolver: ResolverProtocol

    let defaultAssetId: IRAssetId

    var presentationStyle: WalletPresentationStyle = .push(hidesBottomBar: true)

    init(resolver: ResolverProtocol, defaultAssetId: IRAssetId) {
        self.resolver = resolver
        self.defaultAssetId = defaultAssetId
    }
}

extension ScanReceiverCommand: WalletPresentationCommandProtocol {
    func execute() throws {
        guard
            let scanView = InvoiceScanAssembly.assembleView(with: resolver),
            let navigation = resolver.navigation else {
            return
        }

        present(view: scanView, in: navigation)
    }
}
