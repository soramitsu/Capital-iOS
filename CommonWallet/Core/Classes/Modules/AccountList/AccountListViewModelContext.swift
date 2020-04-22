/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

protocol AccountListViewModelContextProtocol {
    var viewModelFactoryContainer: AccountListViewModelFactoryContainer { get }
    var assetCellStyleFactory: AssetCellStyleFactoryProtocol { get }
    var actionsStyle: ActionsCellStyle { get }
    var showMoreCellStyle: WalletTextStyle { get }
    var accountListViewModelFactory: AccountListViewModelFactoryProtocol? { get }
    var minimumVisibleAssets: UInt { get }
}

enum AccountListViewModelContextError: Error {
    case unexpectedViewModelIndex
    case viewModelIndexOutOfBounds
}

struct AccountListViewModelFactoryContainer {
    private(set) var viewModelFactories: [WalletViewModelFactory] = []
    private(set) var assetsIndex: Int = 0
    private(set) var actionsIndex: Int = 1

    var totalViewModelsCount: Int {
        return viewModelFactories.count + 2
    }

    func viewModelListIndex(for globalIndex: Int) -> Int {
        var viewModelIndex = globalIndex

        if globalIndex > assetsIndex {
            viewModelIndex -= 1
        }

        if globalIndex > actionsIndex {
            viewModelIndex -= 1
        }

        return viewModelIndex
    }

    mutating func insert(viewModelFactory: @escaping WalletViewModelFactory, at index: Int) throws {
        guard index >= 0, index <= totalViewModelsCount else {
            throw AccountListViewModelContextError.viewModelIndexOutOfBounds
        }

        let viewModelIndex = viewModelListIndex(for: index)
        viewModelFactories.insert(viewModelFactory, at: viewModelIndex)

        if index <= assetsIndex {
            assetsIndex += 1
        }

        if index <= actionsIndex {
            actionsIndex += 1
        }
    }

    mutating func replace(viewModelFactory: @escaping WalletViewModelFactory, at index: Int) throws {
        guard index >= 0, index < totalViewModelsCount else {
            throw AccountListViewModelContextError.viewModelIndexOutOfBounds
        }

        if index == assetsIndex {
            throw AccountListViewModelContextError.unexpectedViewModelIndex
        }

        if index == actionsIndex {
            throw AccountListViewModelContextError.unexpectedViewModelIndex
        }

        let viewModelIndex = viewModelListIndex(for: index)
        viewModelFactories[viewModelIndex] = viewModelFactory
    }

    mutating func removeViewModel(at index: Int) throws {
        guard index >= 0, index < totalViewModelsCount else {
            throw AccountListViewModelContextError.viewModelIndexOutOfBounds
        }

        if index == assetsIndex {
            throw AccountListViewModelContextError.unexpectedViewModelIndex
        }

        if index == actionsIndex {
            throw AccountListViewModelContextError.unexpectedViewModelIndex
        }

        let viewModelIndex = viewModelListIndex(for: index)
        _ = viewModelFactories.remove(at: viewModelIndex)

        if index <= assetsIndex {
            assetsIndex -= 1
        }

        if index <= actionsIndex {
            actionsIndex -= 1
        }
    }
}

struct AccountListViewModelContext: AccountListViewModelContextProtocol {
    var viewModelFactoryContainer: AccountListViewModelFactoryContainer
    var accountListViewModelFactory: AccountListViewModelFactoryProtocol?
    var assetCellStyleFactory: AssetCellStyleFactoryProtocol
    var actionsStyle: ActionsCellStyle
    var showMoreCellStyle: WalletTextStyle
    var minimumVisibleAssets: UInt
}
