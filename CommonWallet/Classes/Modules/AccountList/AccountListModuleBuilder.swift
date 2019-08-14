/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

enum AccountListModuleBuilderError: Error {
    case unexpectedParameter
}

final class AccountListModuleBuilder {
    fileprivate struct Constants {
        static let assetCellIdentifier: String = "co.jp.capital.asset.cell.identifier"
        static let assetCellHeight: CGFloat = 95.0
        static let showMoreCellIdentifier: String = "co.jp.capital.asset.more.cell.identifier"
        static let showMoreCellHeight: CGFloat = 35.0
        static let actionsCellIdentifier: String = "co.jp.capital.asset.actions.cell.identifier"
        static let actionsCellHeight: CGFloat = 65.0
        static let minimumVisibleAssets: UInt = 2
        static let minimumContentHeight: CGFloat = 0.0
    }

    fileprivate var configuration: AccountListConfiguration!

    lazy var walletStyle: WalletStyleProtocol = WalletStyle()

    private lazy var viewStyle: AccountListViewStyleProtocol = {
        return AccountListViewStyle.createDefaultStyle(with: walletStyle)
    }()

    private lazy var showMoreCellStyle: WalletTextStyle = {
        return WalletTextStyle(font: walletStyle.bodyRegularFont, color: .greyText)
    }()

    private lazy var assetCellStyle: AssetCellStyle = {
        let cardStyle = CardAssetStyle.createDefaultCardStyle(with: walletStyle)
        return .card(cardStyle)
    }()

    private lazy var actionsCellStyle: ActionsCellStyle = {
        return ActionsCellStyle.createDefaultStyle(with: walletStyle)
    }()

    fileprivate lazy var amountFormatter: NumberFormatter = NumberFormatter()

    init() {
        let viewModelContext = AccountListViewModelContext(assetViewModelFactory: createAssetViewModel,
                                                           showMoreViewModelFactory: createShowMoreViewModel,
                                                           actionsViewModelFactory: createActionsViewModel,
                                                           minimumVisibleAssets: Constants.minimumVisibleAssets)

        configuration = AccountListConfiguration(viewStyle: viewStyle,
                                                 registeredCellsMetadata: [:],
                                                 viewModelContext: viewModelContext,
                                                 minimumContentHeight: Constants.minimumContentHeight)

        registerAssetCell()
        registerShowMore()
        registerActions()
    }

    fileprivate func registerAssetCell() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CardAssetCollectionViewCell", bundle: bundle)

        configuration.registeredCellsMetadata[Constants.assetCellIdentifier] = nib
    }

    fileprivate func registerShowMore() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ShowMoreCollectionViewCell", bundle: bundle)

        configuration.registeredCellsMetadata[Constants.showMoreCellIdentifier] = nib
    }

    fileprivate func registerActions() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ActionsCollectionViewCell", bundle: bundle)

        configuration.registeredCellsMetadata[Constants.actionsCellIdentifier] = nib
    }

    fileprivate func createAssetViewModel(from asset: WalletAsset,
                                          balance: BalanceData,
                                          commandFactory: WalletCommandFactoryProtocol)
        throws -> AssetViewModelProtocol {
        let assetDetailsCommand = commandFactory.prepareAssetDetailsCommand(for: asset.identifier)
        let viewModel = AssetViewModel(cellReuseIdentifier: Constants.assetCellIdentifier,
                                       itemHeight: Constants.assetCellHeight,
                                       style: assetCellStyle,
                                       command: assetDetailsCommand)

        viewModel.assetId = asset.identifier.identifier()

        if let decimal = Decimal(string: balance.balance),
            let balanceString = amountFormatter.string(from: decimal as NSNumber) {
            viewModel.amount = balanceString
        } else {
            viewModel.amount = balance.balance
        }

        viewModel.details = asset.details
        viewModel.symbol = asset.symbol

        return viewModel
    }

    fileprivate func createShowMoreViewModel(delegate: ShowMoreViewModelDelegate?) throws
        -> WalletViewModelProtocol {
        let viewModel = ShowMoreViewModel(cellReuseIdentifier: Constants.showMoreCellIdentifier,
                                          itemHeight: Constants.showMoreCellHeight,
                                          style: showMoreCellStyle)
        viewModel.delegate = delegate
        return viewModel
    }

    fileprivate func createActionsViewModel(commandFactory: WalletCommandFactoryProtocol)
        throws -> ActionsViewModelProtocol {
        let sendCommand = commandFactory.prepareSendCommand()
        let receiveCommand = commandFactory.prepareReceiveCommand()

        let viewModel = ActionsViewModel(cellReuseIdentifier: Constants.actionsCellIdentifier,
                                         itemHeight: Constants.actionsCellHeight,
                                         style: actionsCellStyle,
                                         sendCommand: sendCommand,
                                         receiveCommand: receiveCommand)
        return viewModel
    }

    func build() throws -> AccountListConfigurationProtocol {
        return configuration
    }
}

extension AccountListModuleBuilder: AccountListModuleBuilderProtocol {
    var assetCellIdentifier: String {
        return Constants.assetCellIdentifier
    }

    var actionsCellIdentifier: String {
        return Constants.actionsCellIdentifier
    }

    var showMoreCellIdentifier: String {
        return Constants.showMoreCellIdentifier
    }

    func with<Cell>(cellClass: Cell.Type?,
                    for reuseIdentifier: String) -> Self where Cell: UICollectionViewCell & WalletViewProtocol {
        configuration.registeredCellsMetadata[reuseIdentifier] = cellClass
        return self
    }

    func with(cellNib: UINib?, for reuseIdentifier: String) -> Self {
        configuration.registeredCellsMetadata[reuseIdentifier] = cellNib
        return self
    }

    func replacing(viewModelFactory: @escaping WalletViewModelFactory, at index: Int) throws -> Self {
        try configuration.viewModelContext.replace(viewModelFactory: viewModelFactory, at: index)
        return self
    }

    func inserting(viewModelFactory: @escaping WalletViewModelFactory, at index: Int) throws -> Self {
        try configuration.viewModelContext.insert(viewModelFactory: viewModelFactory, at: index)
        return self
    }

    func removingViewModel(at index: Int) throws -> Self {
        try configuration.viewModelContext.removeViewModel(at: index)
        return self
    }

    func withAsset<Cell>(cellClass: Cell.Type) -> Self where Cell: UICollectionViewCell & WalletViewProtocol {
        configuration.registeredCellsMetadata[Constants.assetCellIdentifier] = cellClass
        return self
    }

    func withAsset(cellNib: UINib) -> Self {
        configuration.registeredCellsMetadata[Constants.assetCellIdentifier] = cellNib
        return self
    }

    func with(assetViewModelFactory: @escaping AssetViewModelFactory) throws -> Self {
        configuration.viewModelContext.assetViewModelFactory = assetViewModelFactory
        return self
    }

    func with(viewStyle: AccountListViewStyleProtocol) throws -> Self {
        self.viewStyle = viewStyle
        return self
    }

    func with(assetCellStyle: AssetCellStyle) throws -> Self {
        self.assetCellStyle = assetCellStyle
        return self
    }

    func withShowMore<Cell>(cellClass: Cell.Type) -> Self where Cell: UICollectionViewCell & WalletViewProtocol {
        configuration.registeredCellsMetadata[Constants.showMoreCellIdentifier] = cellClass
        return self
    }

    func withShowMore(cellNib: UINib) -> Self {
        configuration.registeredCellsMetadata[Constants.showMoreCellIdentifier] = cellNib
        return self
    }

    func with(showMoreViewModelFactory: @escaping ShowMoreViewModelFactory) throws -> Self {
        configuration.viewModelContext.showMoreViewModelFactory = showMoreViewModelFactory
        return self
    }

    func with(showMoreStyle: WalletTextStyle) throws -> Self {
        self.showMoreCellStyle = showMoreStyle
        return self
    }

    func withActions<Cell>(cellClass: Cell.Type) -> Self where Cell: UICollectionViewCell & WalletViewProtocol {
        configuration.registeredCellsMetadata[Constants.actionsCellIdentifier] = cellClass
        return self
    }

    func withActions(cellNib: UINib) -> Self {
        configuration.registeredCellsMetadata[Constants.actionsCellIdentifier] = cellNib
        return self
    }

    func with(actionsViewModelFactory: @escaping ActionsViewModelFactory) throws -> Self {
        configuration.viewModelContext.actionsViewModelFactory = actionsViewModelFactory
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

        configuration.viewModelContext.minimumVisibleAssets = minimumVisibleAssets
        return self
    }

    func with(amountFormatter: NumberFormatter) -> Self {
        self.amountFormatter = amountFormatter
        return self
    }

    func with(minimumContentHeight: CGFloat) -> Self {
        configuration.minimumContentHeight = minimumContentHeight
        return self
    }
}
