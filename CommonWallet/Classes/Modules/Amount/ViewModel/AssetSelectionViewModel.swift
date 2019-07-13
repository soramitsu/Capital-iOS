/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication

@objc protocol AssetSelectionViewModelObserver: class {
    func assetSelectionDidChangeTitle()
    func assetSelectionDidChangeSymbol()
    func assetSelectionDidChangeState()
}

protocol AssetSelectionViewModelProtocol: class {
    var title: String { get }
    var symbol: String { get }
    var isSelecting: Bool { get }
    var isValid: Bool { get }
    var canSelect: Bool { get }

    var observable: WalletViewModelObserverContainer<AssetSelectionViewModelObserver> { get }
}

final class AssetSelectionViewModel: AssetSelectionViewModelProtocol {
    var title: String {
        didSet {
            if title != oldValue {
                observable.observers.forEach { $0.observer?.assetSelectionDidChangeTitle() }
            }
        }
    }

    var symbol: String {
        didSet {
            if symbol != oldValue {
                observable.observers.forEach { $0.observer?.assetSelectionDidChangeSymbol() }
            }
        }
    }

    var isSelecting: Bool = false {
        didSet {
            if isSelecting != oldValue {
                observable.observers.forEach { $0.observer?.assetSelectionDidChangeState() }
            }
        }
    }

    var isValid: Bool {
        return assetId != nil
    }

    var canSelect: Bool = true

    var assetId: IRAssetId?

    private(set) var observable: WalletViewModelObserverContainer<AssetSelectionViewModelObserver>

    init(assetId: IRAssetId?, title: String, symbol: String) {
        self.assetId = assetId
        self.title = title
        self.symbol = symbol

        observable = WalletViewModelObserverContainer()
    }
}
