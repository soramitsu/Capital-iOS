/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

protocol WalletEventProtocol {
    func accept(visitor: WalletEventVisitorProtocol)
}

protocol WalletEventCenterProtocol {
    func notify(with event: WalletEventProtocol)
    func add(observer: WalletEventVisitorProtocol, dispatchIn queue: DispatchQueue?)
    func remove(observer: WalletEventVisitorProtocol)
}

extension WalletEventCenterProtocol {
    func add(observer: WalletEventVisitorProtocol) {
        add(observer: observer, dispatchIn: nil)
    }
}
