/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation


final class TransactionDetailsPresenter {
    weak var view: WalletNewFormViewProtocol?
    var coordinator: TransactionDetailsCoordinatorProtocol
    let transactionData: AssetTransactionData
    let viewModelFactory: WalletTransactionDetailsFactoryProtocol
    let commandFactory: WalletCommandFactoryProtocol

    init(view: WalletNewFormViewProtocol,
         coordinator: TransactionDetailsCoordinatorProtocol,
         transactionData: AssetTransactionData,
         detailsViewModelFactory: WalletTransactionDetailsFactoryProtocol,
         commandFactory: WalletCommandFactoryProtocol) {
        self.view = view
        self.coordinator = coordinator
        self.transactionData = transactionData
        self.viewModelFactory = detailsViewModelFactory
        self.commandFactory = commandFactory
    }

    private func updateView() {
        let locale = localizationManager?.selectedLocale ?? Locale.current
        let mainViewModels = viewModelFactory
            .createViewModelsFromTransaction(data: transactionData,
                                             commandFactory: commandFactory,
                                             locale: locale)

        view?.didReceive(viewModels: mainViewModels)

        let accessoryViewModel = viewModelFactory
            .createAccessoryViewModelFromTransaction(data: transactionData,
                                                     commandFactory: commandFactory,
                                                     locale: locale)
        view?.didReceive(accessoryViewModel: accessoryViewModel)
    }
}


extension TransactionDetailsPresenter: TransactionDetailsPresenterProtocol {
    func setup() {
        updateView()
    }

    func performAction() {
        let receiverInfo = ReceiveInfo(accountId: transactionData.peerId,
                                       assetId: transactionData.assetId,
                                       amount: nil,
                                       details: nil)

        let receiverName: String = transactionData.localizedPeerName

        let payload = TransferPayload(receiveInfo: receiverInfo,
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
