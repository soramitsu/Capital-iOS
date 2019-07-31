/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation

@objc protocol WithdrawFeeViewModelObserver {
    @objc optional func feeTitleDidChange()
    @objc optional func feeLoadingStateDidChange()
}

protocol WithdrawFeeViewModelProtocol: class {
    var title: String { get }
    var isLoading: Bool { get }

    var observable: WalletViewModelObserverContainer<WithdrawFeeViewModelObserver> { get }
}

final class WithdrawFeeViewModel: WithdrawFeeViewModelProtocol {
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

    var observable: WalletViewModelObserverContainer<WithdrawFeeViewModelObserver>

    init(title: String) {
        self.title = title

        observable = WalletViewModelObserverContainer()
    }
}
