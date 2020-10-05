/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public struct WalletViewModelObserverWrapper<Observer> where Observer: AnyObject {
    weak var observer: Observer?

    init(observer: Observer) {
        self.observer = observer
    }
}

public final class WalletViewModelObserverContainer<Observer> where Observer: AnyObject {
    private(set) var observers: [WalletViewModelObserverWrapper<Observer>] = []

    public func add(observer: Observer) {
        observers = observers.filter { $0.observer != nil }

        guard !observers.contains(where: { $0.observer === observer }) else {
            return
        }

        observers.append(WalletViewModelObserverWrapper(observer: observer))
    }

    public func remove(observer: Observer) {
        observers = observers.filter { $0.observer != nil && $0.observer !== observer }
    }
}
