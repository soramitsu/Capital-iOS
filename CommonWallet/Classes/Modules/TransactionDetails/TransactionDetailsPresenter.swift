/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication
import SoraFoundation


final class TransactionDetailsPresenter {
    weak var view: WalletFormViewProtocol?
    var coordinator: TransactionDetailsCoordinatorProtocol

    let configuration: TransactionDetailsConfigurationProtocol
    let transactionData: AssetTransactionData
    let transactionType: WalletTransactionType
    let asset: WalletAsset
    let accessoryViewModelFactory: ContactAccessoryViewModelFactoryProtocol
    let viewModelFactory: WalletTransactionDetailsFactoryProtocol

    init(view: WalletFormViewProtocol,
         coordinator: TransactionDetailsCoordinatorProtocol,
         configuration: TransactionDetailsConfigurationProtocol,
         detailsViewModelFactory: WalletTransactionDetailsFactoryProtocol,
         accessoryViewModelFactory: ContactAccessoryViewModelFactoryProtocol,
         transactionData: AssetTransactionData,
         transactionType: WalletTransactionType,
         asset: WalletAsset) {
        self.view = view
        self.coordinator = coordinator
        self.configuration = configuration
        self.transactionData = transactionData
        self.transactionType = transactionType
        self.asset = asset
        self.viewModelFactory = detailsViewModelFactory
        self.accessoryViewModelFactory = accessoryViewModelFactory
    }

    private func createAccessoryViewModel(actionTitle: String) -> AccessoryViewModel {
        let peerName = transactionData.localizedPeerName

        return accessoryViewModelFactory.createViewModel(from: peerName,
                                                         fullName: peerName,
                                                         action: actionTitle)
    }

    private func updateView() {
        let mainViewModels = viewModelFactory.createForm(from: transactionData,
                                                         type: transactionType,
                                                         asset: asset)

        view?.didReceive(viewModels: mainViewModels)

        if transactionType.isIncome,
            configuration.sendBackTransactionTypes.contains(transactionType.backendName) {
            let accessoryViewModel = createAccessoryViewModel(actionTitle: L10n.Transaction.sendBack)
            view?.didReceive(accessoryViewModel: accessoryViewModel)
        }

        if !transactionType.isIncome,
            configuration.sendAgainTransactionTypes.contains(transactionType.backendName) {
            let accessoryViewModel = createAccessoryViewModel(actionTitle: L10n.Transaction.sendAgain)
            view?.didReceive(accessoryViewModel: accessoryViewModel)
        }
    }
}


extension TransactionDetailsPresenter: TransactionDetailsPresenterProtocol {
    func setup() {
        updateView()
    }

    func performAction() {
        guard
            let accountId = try? IRAccountIdFactory.account(withIdentifier: transactionData.peerId),
            let assetId = try? IRAssetIdFactory.asset(withIdentifier: transactionData.assetId) else {
            return
        }

        let receiverInfo = ReceiveInfo(accountId: accountId,
                                       assetId: assetId,
                                       amount: nil,
                                       details: nil)

        let receiverName: String = transactionData.localizedPeerName

        let payload = AmountPayload(receiveInfo: receiverInfo,
                                    receiverName: receiverName)

        coordinator.send(to: payload)
    }
}


extension TransactionDetailsPresenter: Localizable {
    func applyLocalization() {
        if view?.isSetup == true {
            updateView()
        }
    }
}
