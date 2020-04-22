/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation

@objc protocol FeeViewModelObserver {
    @objc optional func feeTitleDidChange()
    @objc optional func feeLoadingStateDidChange()
}

protocol FeeViewModelProtocol: class {
    var title: String { get }
    var isLoading: Bool { get }

    var observable: WalletViewModelObserverContainer<FeeViewModelObserver> { get }
}

final class FeeViewModel: FeeViewModelProtocol {
    var title: String {
        didSet {
            observable.observers.forEach {
                $0.observer?.feeTitleDidChange?()
            }
        }
    }

    var isLoading: Bool = false {
        didSet {
            observable.observers.forEach {
                $0.observer?.feeLoadingStateDidChange?()
            }
        }
    }

    var observable: WalletViewModelObserverContainer<FeeViewModelObserver>

    init(title: String) {
        self.title = title

        observable = WalletViewModelObserverContainer()
    }
}
