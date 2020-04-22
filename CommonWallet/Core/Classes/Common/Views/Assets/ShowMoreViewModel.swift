/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

@objc protocol ShowMoreViewModelObserver: class {
    @objc optional func didChangeExpanded(oldValue: Bool)
}

protocol ShowMoreViewModelProtocol: WalletViewModelProtocol {
    var collapsedTitle: String { get }
    var expandedTitle: String { get }
    var expanded: Bool { get }
    var style: WalletTextStyleProtocol { get }

    var observable: WalletViewModelObserverContainer<ShowMoreViewModelObserver> { get }
}

public protocol ShowMoreViewModelDelegate: class {
    func shouldToggleExpansion(from value: Bool, for viewModel: WalletViewModelProtocol) -> Bool
}

final class ShowMoreViewModel: ShowMoreViewModelProtocol {
    var cellReuseIdentifier: String
    var itemHeight: CGFloat
    var collapsedTitle: String = L10n.Common.showMore
    var expandedTitle: String = L10n.Common.showLess

    var observable = WalletViewModelObserverContainer<ShowMoreViewModelObserver>()

    var expanded: Bool = false {
        didSet {
            if expanded != oldValue {
                observable.observers.forEach { $0.observer?.didChangeExpanded?(oldValue: oldValue) }
            }
        }
    }

    var style: WalletTextStyleProtocol

    weak var delegate: ShowMoreViewModelDelegate?

    init(cellReuseIdentifier: String, itemHeight: CGFloat, style: WalletTextStyleProtocol) {
        self.cellReuseIdentifier = cellReuseIdentifier
        self.itemHeight = itemHeight
        self.style = style
    }
}

extension ShowMoreViewModel: WalletCommandProtocol {
    var command: WalletCommandProtocol? { return self }

    func execute() throws {
        if let delegate = delegate {
            if delegate.shouldToggleExpansion(from: expanded, for: self) {
                expanded = !expanded
            }
        } else {
            expanded = !expanded
        }
    }
}
