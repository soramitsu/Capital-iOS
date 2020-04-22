/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol AccountListModuleBuilderProtocol: class {
    var assetCellIdentifier: String { get }
    var showMoreCellIdentifier: String { get }
    var actionsCellIdentifier: String { get }

    @discardableResult
    func with<Cell>(cellClass: Cell.Type?,
                    for reuseIdentifier: String) -> Self where Cell: UICollectionViewCell & WalletViewProtocol

    @discardableResult
    func with(cellNib: UINib?, for reuseIdentifier: String) -> Self

    @discardableResult
    func replacing(viewModelFactory: @escaping WalletViewModelFactory, at index: Int) throws -> Self

    @discardableResult
    func inserting(viewModelFactory: @escaping WalletViewModelFactory, at index: Int) throws -> Self

    @discardableResult
    func removingViewModel(at index: Int) throws -> Self

    @discardableResult
    func with(listViewModelFactory: AccountListViewModelFactoryProtocol) throws -> Self

    @discardableResult
    func withAsset<Cell>(cellClass: Cell.Type) -> Self where Cell: UICollectionViewCell & WalletViewProtocol

    @discardableResult
    func withAsset(cellNib: UINib) -> Self

    @discardableResult
    func with(viewStyle: AccountListViewStyleProtocol) throws -> Self

    @discardableResult
    func with(assetCellStyleFactory: AssetCellStyleFactoryProtocol) throws -> Self

    @discardableResult
    func withShowMore<Cell>(cellClass: Cell.Type) -> Self where Cell: UICollectionViewCell & WalletViewProtocol

    @discardableResult
    func withShowMore(cellNib: UINib) -> Self

    @discardableResult
    func with(showMoreStyle: WalletTextStyle) throws -> Self

    @discardableResult
    func withActions<Cell>(cellClass: Cell.Type) -> Self where Cell: UICollectionViewCell & WalletViewProtocol

    @discardableResult
    func withActions(cellNib: UINib) -> Self

    @discardableResult
    func with(actionsStyle: ActionsCellStyle) throws -> Self

    @discardableResult
    func with(minimumVisibleAssets: UInt) throws -> Self

    @discardableResult
    func with(minimumContentHeight: CGFloat) -> Self
}
