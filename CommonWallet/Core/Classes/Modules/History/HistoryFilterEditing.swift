/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol HistoryFilterEditing: AnyObject {
    func startEditing(filter: WalletHistoryRequest,
                      with assets: [WalletAsset],
                      commandFactory: WalletCommandFactoryProtocol,
                      notifying delegate: HistoryFilterEditingDelegate?)
}

public protocol HistoryFilterEditingDelegate: AnyObject {
    func historyFilterDidEdit(request: WalletHistoryRequest)
}
