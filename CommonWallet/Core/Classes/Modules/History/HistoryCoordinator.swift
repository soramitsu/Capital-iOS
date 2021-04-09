/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

final class HistoryCoordinator: HistoryCoordinatorProtocol {
    let resolver: ResolverProtocol
    let filterEditor: HistoryFilterEditing

    init(resolver: ResolverProtocol, filterEditor: HistoryFilterEditing) {
        self.resolver = resolver
        self.filterEditor = filterEditor
    }
    
    weak var delegate: HistoryCoordinatorDelegate?

    func presentFilter(filter: WalletHistoryRequest, assets: [WalletAsset]) {
        filterEditor.startEditing(filter: filter,
                                  with: assets,
                                  commandFactory: resolver.commandFactory,
                                  notifying: self)
    }
    
}


extension HistoryCoordinator: HistoryFilterEditingDelegate {
    func historyFilterDidEdit(request: WalletHistoryRequest) {
        delegate?.coordinator(self, didReceive: request)
    }

    func set(filter: WalletHistoryRequest) {
        delegate?.coordinator(self, didReceive: filter)
    }
    
}
