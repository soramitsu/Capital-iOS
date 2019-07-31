/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood
import IrohaCommunication


final class AmountPresenter {
    enum InputState {
        case waiting
        case checking
    }

    weak var view: AmountViewProtocol?
    var coordinator: AmountCoordinatorProtocol
    var logger: WalletLoggerProtocol?
    
    private var assetSelectionViewModel: AssetSelectionViewModel
    private var amountInputViewModel: AmountInputViewModel
    private var descriptionInputViewModel: DescriptionInputViewModel
    private var accessoryViewModel: AccessoryViewModelProtocol

    private var balances: [BalanceData]?
    private let account: WalletAccountSettingsProtocol
    private let balanceDataProvider: SingleValueProvider<[BalanceData], CDCWSingleValue>
    private var payload: AmountPayload
    private var assetSelectionFactory: AssetSelectionFactoryProtocol

    private var state: InputState = .waiting
    
    init(view: AmountViewProtocol,
         coordinator: AmountCoordinatorProtocol,
         balanceDataProvider: SingleValueProvider<[BalanceData], CDCWSingleValue>,
         account: WalletAccountSettingsProtocol,
         payload: AmountPayload,
         assetSelectionFactory: AssetSelectionFactoryProtocol,
         accessoryFactory: ContactAccessoryViewModelFactoryProtocol,
         amountLimit: Decimal,
         descriptionMaxLength: UInt8) {
        self.view = view
        self.coordinator = coordinator
        self.balanceDataProvider = balanceDataProvider
        self.account = account
        self.payload = payload
        self.assetSelectionFactory = assetSelectionFactory

        var optionalAsset: WalletAsset?
        var currentAmount: Decimal?

        if let asset = account.asset(for: payload.receiveInfo.assetId.identifier()) {
            optionalAsset = asset

            if let amount = payload.receiveInfo.amount {
                currentAmount = Decimal(string: amount.value)
            }
        } else {
            optionalAsset = account.assets.first
        }

        let title = assetSelectionFactory.createTitle(for: optionalAsset, balanceData: nil)
        assetSelectionViewModel = AssetSelectionViewModel(assetId: optionalAsset?.identifier,
                                                          title: title,
                                                          symbol: optionalAsset?.symbol ?? "")
        assetSelectionViewModel.canSelect = account.assets.count > 1

        amountInputViewModel = AmountInputViewModel(optionalAmount: currentAmount, limit: amountLimit)

        let placeholder = "Maximum \(descriptionMaxLength) symbols"
        descriptionInputViewModel = DescriptionInputViewModel(title: "Description",
                                                              text: "",
                                                              placeholder: placeholder,
                                                              maxLength: descriptionMaxLength)

        accessoryViewModel = accessoryFactory.createViewModel(from: payload.receiverName,
                                                              fullName: payload.receiverName,
                                                              action: "Next")
    }
    
    private func handleResponse(with optionalBalances: [BalanceData]?) {
        defer {
            state = .waiting
        }

        if let balances = optionalBalances {
            self.balances = balances
        }

        guard let balances = self.balances else {
            return
        }
        
        guard
            let assetId = assetSelectionViewModel.assetId,
            let asset = account.asset(for: assetId.identifier()),
            let balanceData = balances.first(where: { $0.identifier == assetId.identifier()}) else {

                if state == .checking {
                    let message = "Sorry, we couldn't find asset information you want to send. Please, try again later."
                    view?.showError(message: message)
                }

            return
        }

        assetSelectionViewModel.title = assetSelectionFactory.createTitle(for: asset, balanceData: balanceData)

        if state == .checking {
            view?.didStopLoading()

            performConfirmation()
        }
    }

    private func handleResponse(with error: Error) {
        if state == .checking {
            view?.didStopLoading()

            state = .waiting

            let message = "Sorry, balance checking request failed. Please, try again later."
            view?.showError(message: message)
        }
    }
    
    private func setupBalanceDataProvider() {
        let changesBlock = { [weak self] (changes: [DataProviderChange<[BalanceData]>]) -> Void in
            if let change = changes.first {
                switch change {
                case .insert(let items), .update(let items):
                    self?.handleResponse(with: items)
                default:
                    break
                }
            } else {
                self?.handleResponse(with: nil)
            }
        }
        
        let failBlock: (Error) -> Void = { [weak self] (error: Error) in
            self?.handleResponse(with: error)
        }

        let options = DataProviderObserverOptions(alwaysNotifyOnRefresh: true)
        balanceDataProvider.addCacheObserver(self,
                                             deliverOn: .main,
                                             executing: changesBlock,
                                             failing: failBlock,
                                             options: options)
    }

    private func performConfirmation() {
        guard
            let assetId = assetSelectionViewModel.assetId,
            let asset = account.asset(for: assetId.identifier()),
            let sendingDecimalAmount = amountInputViewModel.decimalAmount,
            let amount = try? IRAmountFactory.amount(from: (sendingDecimalAmount as NSNumber).stringValue) else {
                return
        }

        guard
            let balanceData = balances?.first(where: { $0.identifier == assetId.identifier()}),
            let currentAmount =  Decimal(string: balanceData.balance),
            sendingDecimalAmount <= currentAmount else {
                let message = "Sorry, you don't have enough funds to transfer specified amount."
                view?.showError(message: message)
                return
        }

        let transferInfo = TransferInfo(source: account.accountId,
                                        destination: payload.receiveInfo.accountId,
                                        amount: amount,
                                        asset: assetId,
                                        details: descriptionInputViewModel.text)

        let composedPayload = TransferPayload(transferInfo: transferInfo,
                                              receiverName: payload.receiverName,
                                              assetSymbol: asset.symbol)

        coordinator.confirm(with: composedPayload)
    }
}


extension AmountPresenter: AmountPresenterProtocol {

    func setup() {
        view?.set(assetViewModel: assetSelectionViewModel)
        view?.set(amountViewModel: amountInputViewModel)
        view?.set(descriptionViewModel: descriptionInputViewModel)
        view?.set(accessoryViewModel: accessoryViewModel)

        setupBalanceDataProvider()
    }
    
    func confirm() {
        if state == .waiting {
            view?.didStartLoading()

            state = .checking
            balanceDataProvider.refreshCache()
        }
    }
    
    func presentAssetSelection() {
        var initialIndex = 0

        if let assetId = assetSelectionViewModel.assetId {
            initialIndex = account.assets.firstIndex(where: { $0.identifier.identifier() == assetId.identifier() }) ?? 0
        }

        let titles: [String] = account.assets.map { (asset) in
            let balanceData = balances?.first { $0.identifier == asset.identifier.identifier() }
            return assetSelectionFactory.createTitle(for: asset, balanceData: balanceData)
        }

        coordinator.presentPicker(for: titles, initialIndex: initialIndex, delegate: self)

        assetSelectionViewModel.isSelecting = true
    }

}

extension AmountPresenter: ModalPickerViewDelegate {
    func modalPickerViewDidCancel(_ view: ModalPickerView) {
        assetSelectionViewModel.isSelecting = false
    }

    func modalPickerView(_ view: ModalPickerView, didSelectRowAt index: Int, in context: AnyObject?) {
        assetSelectionViewModel.isSelecting = false

        let newAsset = account.assets[index]

        assetSelectionViewModel.assetId = newAsset.identifier

        let balanceData = balances?.first { $0.identifier == newAsset.identifier.identifier() }
        let title = assetSelectionFactory.createTitle(for: newAsset, balanceData: balanceData)

        assetSelectionViewModel.title = title

        assetSelectionViewModel.symbol = newAsset.symbol
    }

}
