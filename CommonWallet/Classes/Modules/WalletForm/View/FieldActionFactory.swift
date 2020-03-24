/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraFoundation

public enum WalletFormField {
    case transactionId
    case peerId
}

public protocol WalletFieldActionFactoryProtocol {
    func createActions(for field: WalletFormField,
                       data: AssetTransactionData) -> [WalletSelectableAction<AssetTransactionData>]?
}

public extension WalletFieldActionFactoryProtocol {
    func createCopyAction(for field: WalletFormField,
                          data: AssetTransactionData) -> WalletSelectableAction<AssetTransactionData> {
        let title = LocalizableResource { _ in L10n.Common.copy }
        return WalletSelectableAction(title: title) { (data: AssetTransactionData) in
            let text: String

            switch field {
            case .transactionId:
                text = data.transactionId
            case .peerId:
                text = data.peerId
            }

            UIPasteboard.general.string = text
        }
    }
}

struct WalletFieldActionFactory: WalletFieldActionFactoryProtocol {
    func createActions(for field: WalletFormField,
                       data: AssetTransactionData) -> [WalletSelectableAction<AssetTransactionData>]? {
        let copy = createCopyAction(for: field, data: data)
        return [copy]
    }
}
