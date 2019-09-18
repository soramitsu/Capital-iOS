/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication


final class TransactionDetailsPresenter {
    weak var view: WalletFormViewProtocol?
    var coordinator: TransactionDetailsCoordinatorProtocol

    private(set) var resolver: ResolverProtocol
    private(set) var transactionData: AssetTransactionData
    private(set) var transactionType: WalletTransactionType

    init(view: WalletFormViewProtocol,
         coordinator: TransactionDetailsCoordinatorProtocol,
         resolver: ResolverProtocol,
         transactionData: AssetTransactionData,
         transactionType: WalletTransactionType) {
        self.view = view
        self.coordinator = coordinator
        self.resolver = resolver
        self.transactionData = transactionData
        self.transactionType = transactionType
    }

    private func createStatusViewModel(for status: AssetTransactionStatus) -> WalletFormViewModel {
        switch status {
        case .commited:
            return WalletFormViewModel(layoutType: .accessory,
                                       title: "Status",
                                       details: "Success",
                                       detailsColor: resolver.style.statusStyleContainer.approved.color,
                                       icon: resolver.style.statusStyleContainer.approved.icon)
        case .pending:
            return WalletFormViewModel(layoutType: .accessory,
                                       title: "Status",
                                       details: "Pending",
                                       detailsColor: resolver.style.statusStyleContainer.pending.color,
                                       icon: resolver.style.statusStyleContainer.pending.icon)
        case .rejected:
            return WalletFormViewModel(layoutType: .accessory,
                                       title: "Status",
                                       details: "Rejected",
                                       detailsColor: resolver.style.statusStyleContainer.rejected.color,
                                       icon: resolver.style.statusStyleContainer.rejected.icon)
        }
    }

    private func createAmountViewModel(for amount: Decimal, title: String, hasIcon: Bool) -> WalletFormViewModel {
        let asset = resolver.account.assets.first {
            $0.identifier.identifier() == transactionData.assetId
        }

        let assetSymbol = asset?.symbol ?? ""
        let amountString = resolver.amountFormatter.string(from: amount as NSNumber) ?? ""

        let details = assetSymbol + amountString

        var icon: UIImage?

        if hasIcon {
            icon = transactionType.isIncome ? resolver.style.amountChangeStyle.increase
                : resolver.style.amountChangeStyle.decrease
        }

        return WalletFormViewModel(layoutType: .accessory,
                                   title: title,
                                   details: details,
                                   icon: icon)
    }

    private func createPeerViewModel() -> WalletFormViewModel? {
        if transactionType.backendName == WalletTransactionType.incoming.backendName {
            return WalletFormViewModel(layoutType: .accessory,
                                       title: "Sender",
                                       details: transactionData.peerName)
        }

        if transactionType.backendName == WalletTransactionType.outgoing.backendName {
            return WalletFormViewModel(layoutType: .accessory,
                                       title: "Recipient",
                                       details: transactionData.peerName)
        }

        return nil
    }

    private func createAmountFactorViewModels() -> [WalletFormViewModel] {
        guard let amount = Decimal(string: transactionData.amount) else {
            return []
        }

        if let feeString = transactionData.fee, let fee = Decimal(string: feeString), fee > 0.0 {
            let totalAmount = amount + fee

            return [createAmountViewModel(for: amount, title: "Amount sent", hasIcon: false),
                    createAmountViewModel(for: fee, title: "Fee", hasIcon: false),
                    createAmountViewModel(for: totalAmount, title: "Total amount", hasIcon: true)]
        } else {
            return [createAmountViewModel(for: amount, title: "Amount", hasIcon: true)]
        }
    }

    private func updateView() {
        var viewModels = [WalletFormViewModel]()

        let idViewModel = WalletFormViewModel(layoutType: .accessory,
                                              title: "Identifier",
                                              details: transactionData.displayIdentifier)
        viewModels.append(idViewModel)

        let statusViewModel: WalletFormViewModel = createStatusViewModel(for: transactionData.status)
        viewModels.append(statusViewModel)

        if transactionData.status == .rejected, let reason = transactionData.reason {
            let reasonViewModel = WalletFormViewModel(layoutType: .details,
                                                      title: "Reason",
                                                      details: reason)
            viewModels.append(reasonViewModel)
        }

        let transactionDate = Date(timeIntervalSince1970: TimeInterval(transactionData.timestamp))
        let timeViewModel = WalletFormViewModel(layoutType: .accessory,
                                                title: "Date and Time",
                                                details: resolver.statusDateFormatter.string(from: transactionDate))
        viewModels.append(timeViewModel)

        let typeViewModel = WalletFormViewModel(layoutType: .accessory,
                                                title: "Type",
                                                details: transactionType.displayName)
        viewModels.append(typeViewModel)

        if let peerViewModel = createPeerViewModel() {
            viewModels.append(peerViewModel)
        }

        viewModels.append(contentsOf: createAmountFactorViewModels())

        if !transactionData.details.isEmpty {
            let descriptionViewModel = WalletFormViewModel(layoutType: .details,
                                                           title: "Description",
                                                           details: transactionData.details)

            viewModels.append(descriptionViewModel)
        }

        view?.didReceive(viewModels: viewModels)
    }
}


extension TransactionDetailsPresenter: TransactionDetailsPresenterProtocol {
    func setup() {
        updateView()
    }

    func performAction() {}
}
