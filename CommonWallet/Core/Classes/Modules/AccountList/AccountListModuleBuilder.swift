/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

enum AccountListModuleBuilderError: Error {
    case unexpectedParameter
}

final class AccountListModuleBuilder {
    lazy var walletStyle: WalletStyleProtocol = WalletStyle()

    private lazy var viewStyle: AccountListViewStyleProtocol = {
        return AccountListViewStyle.createDefaultStyle(with: walletStyle)
    }()

    private lazy var showMoreCellStyle: WalletTextStyle = {
        return WalletTextStyle(font: walletStyle.bodyRegularFont, color: .greyText)
    }()

    private lazy var assetCellStyleFactory: AssetCellStyleFactoryProtocol = {
        return AssetCellStyleFactory(style: walletStyle)
    }()

    private lazy var actionsCellStyle: ActionsCellStyle = {
        return ActionsCellStyle.createDefaultStyle(with: walletStyle)
    }()

    fileprivate var viewModelFactoryContainer = AccountListViewModelFactoryContainer()

    fileprivate var accountListViewModelFactory: AccountListViewModelFactoryProtocol?

    fileprivate var registeredCellsMetadata = [String: Any]()

    fileprivate var minimumVisibleAssets: UInt = 2

    fileprivate var minimumContentHeight: CGFloat = 0.0

    init() {
        registerAssetCell()
        registerShowMore()
        registerActions()
    }

    fileprivate func registerAssetCell() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CardAssetCollectionViewCell", bundle: bundle)

        registeredCellsMetadata[AccountModuleConstants.assetCellIdentifier] = nib
    }

    fileprivate func registerShowMore() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ShowMoreCollectionViewCell", bundle: bundle)

        registeredCellsMetadata[AccountModuleConstants.showMoreCellIdentifier] = nib
    }

    fileprivate func registerActions() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ActionsCollectionViewCell", bundle: bundle)

        registeredCellsMetadata[AccountModuleConstants.actionsCellIdentifier] = nib
    }

    func build() throws -> AccountListConfigurationProtocol {
        let viewModelContext = AccountListViewModelContext(viewModelFactoryContainer: viewModelFactoryContainer,
                                                           accountListViewModelFactory: accountListViewModelFactory,
                                                           assetCellStyleFactory: assetCellStyleFactory,
                                                           actionsStyle: actionsCellStyle,
                                                           showMoreCellStyle: showMoreCellStyle,
                                                           minimumVisibleAssets: minimumVisibleAssets)

        return AccountListConfiguration(viewStyle: viewStyle,
                                        registeredCellsMetadata: registeredCellsMetadata,
                                        viewModelContext: viewModelContext,
                                        minimumContentHeight: minimumContentHeight)
    }
}

extension AccountListModuleBuilder: AccountListModuleBuilderProtocol {
    var assetCellIdentifier: String {
        return AccountModuleConstants.assetCellIdentifier
    }

    var actionsCellIdentifier: String {
        return AccountModuleConstants.actionsCellIdentifier
    }

    var showMoreCellIdentifier: String {
        return AccountModuleConstants.showMoreCellIdentifier
    }

    func with<Cell>(cellClass: Cell.Type?,
                    for reuseIdentifier: String) -> Self where Cell: UICollectionViewCell & WalletViewProtocol {
        registeredCellsMetadata[reuseIdentifier] = cellClass
        return self
    }

    func with(cellNib: UINib?, for reuseIdentifier: String) -> Self {
        registeredCellsMetadata[reuseIdentifier] = cellNib
        return self
    }

    func replacing(viewModelFactory: @escaping WalletViewModelFactory, at index: Int) throws -> Self {
        try viewModelFactoryContainer.replace(viewModelFactory: viewModelFactory, at: index)
        return self
    }

    func inserting(viewModelFactory: @escaping WalletViewModelFactory, at index: Int) throws -> Self {
        try viewModelFactoryContainer.insert(viewModelFactory: viewModelFactory, at: index)
        return self
    }

    func removingViewModel(at index: Int) throws -> Self {
        try viewModelFactoryContainer.removeViewModel(at: index)
        return self
    }

    func withAsset<Cell>(cellClass: Cell.Type) -> Self where Cell: UICollectionViewCell & WalletViewProtocol {
        registeredCellsMetadata[AccountModuleConstants.assetCellIdentifier] = cellClass
        return self
    }

    func withAsset(cellNib: UINib) -> Self {
        registeredCellsMetadata[AccountModuleConstants.assetCellIdentifier] = cellNib
        return self
    }

    func with(listViewModelFactory: AccountListViewModelFactoryProtocol) throws -> Self {
        self.accountListViewModelFactory = listViewModelFactory
        return self
    }

    func with(viewStyle: AccountListViewStyleProtocol) throws -> Self {
        self.viewStyle = viewStyle
        return self
    }

    func with(assetCellStyleFactory: AssetCellStyleFactoryProtocol) throws -> Self {
        self.assetCellStyleFactory = assetCellStyleFactory
        return self
    }

    func withShowMore<Cell>(cellClass: Cell.Type) -> Self where Cell: UICollectionViewCell & WalletViewProtocol {
        registeredCellsMetadata[AccountModuleConstants.showMoreCellIdentifier] = cellClass
        return self
    }

    func withShowMore(cellNib: UINib) -> Self {
        registeredCellsMetadata[AccountModuleConstants.showMoreCellIdentifier] = cellNib
        return self
    }

    func with(showMoreStyle: WalletTextStyle) throws -> Self {
        self.showMoreCellStyle = showMoreStyle
        return self
    }

    func withActions<Cell>(cellClass: Cell.Type) -> Self where Cell: UICollectionViewCell & WalletViewProtocol {
        registeredCellsMetadata[AccountModuleConstants.actionsCellIdentifier] = cellClass
        return self
    }

    func withActions(cellNib: UINib) -> Self {
        registeredCellsMetadata[AccountModuleConstants.actionsCellIdentifier] = cellNib
        return self
    }

    func with(actionsStyle: ActionsCellStyle) throws -> Self {
        actionsCellStyle = actionsStyle
        return self
    }

    func with(minimumVisibleAssets: UInt) throws -> Self {
        guard minimumVisibleAssets > 0 else {
            throw AccountListModuleBuilderError.unexpectedParameter
        }

        self.minimumVisibleAssets = minimumVisibleAssets
        return self
    }

    func with(minimumContentHeight: CGFloat) -> Self {
        self.minimumContentHeight = minimumContentHeight
        return self
    }
}
