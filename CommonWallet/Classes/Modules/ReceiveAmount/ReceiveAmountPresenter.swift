/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood
import IrohaCommunication

final class ReceiveAmountPresenter {
    weak var view: ReceiveAmountViewProtocol?
    var coordinator: ReceiveAmountCoordinatorProtocol

    private(set) var qrService: WalletQRServiceProtocol
    private(set) var account: WalletAccountSettingsProtocol
    private(set) var assetSelectionFactory: AssetSelectionFactoryProtocol
    private(set) var assetSelectionViewModel: AssetSelectionViewModel
    private(set) var amountInputViewModel: AmountInputViewModel
    private(set) var preferredQRSize: CGSize?

    private var balances: [BalanceData]?

    var logger: WalletLoggerProtocol?

    private var qrOperation: Operation?

    deinit {
        cancelQRGeneration()
    }

    init(view: ReceiveAmountViewProtocol,
         coordinator: ReceiveAmountCoordinatorProtocol,
         account: WalletAccountSettingsProtocol,
         assetSelectionFactory: AssetSelectionFactoryProtocol,
         qrService: WalletQRServiceProtocol,
         receiveInfo: ReceiveInfo,
         amountLimit: Decimal) {
        self.view = view
        self.coordinator = coordinator
        self.qrService = qrService
        self.account = account
        self.assetSelectionFactory = assetSelectionFactory

        var optionalAsset: WalletAssetProtocol?
        var currentAmount: Decimal?

        if let asset = account.asset(for: receiveInfo.assetId.identifier()) {
            optionalAsset = asset

            if let amount = receiveInfo.amount {
                currentAmount = Decimal(string: amount.value) ?? 0
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
    }

    // MARK: QR generation

    private func generateQR(with size: CGSize) {
        cancelQRGeneration()

        do {
            guard let assetId = assetSelectionViewModel.assetId else {
                return
            }

            var amount: IRAmount?

            if let decimalAmount = amountInputViewModel.decimalAmount, decimalAmount > 0 {
                amount = try IRAmountFactory.amount(from: (decimalAmount as NSNumber).stringValue)
            }

            let receiveInfo = ReceiveInfo(accountId: account.accountId,
                                          assetId: assetId,
                                          amount: amount,
                                          details: nil)

            qrOperation = try qrService.generate(from: receiveInfo, qrSize: size,
                                                 runIn: .main) { [weak self] (operationResult) in
                                                    if let result = operationResult {
                                                        self?.qrOperation = nil
                                                        self?.processOperation(result: result)
                                                    }
            }
        } catch {
            processOperation(result: .error(error))
        }
    }

    private func cancelQRGeneration() {
        qrOperation?.cancel()
        qrOperation = nil
    }

    private func processOperation(result: OperationResult<UIImage>) {
        switch result {
        case .success(let image):
            view?.didReceive(image: image)
        case .error:
            view?.showError(message: "Can't generate QR code")
        }
    }
}


extension ReceiveAmountPresenter: ReceiveAmountPresenterProtocol {
    func setup(qrSize: CGSize) {
        assetSelectionViewModel.observable.remove(observer: self)
        assetSelectionViewModel.observable.add(observer: self)

        amountInputViewModel.observable.remove(observer: self)
        amountInputViewModel.observable.add(observer: self)

        view?.didReceive(assetSelectionViewModel: assetSelectionViewModel)
        view?.didReceive(amountInputViewModel: amountInputViewModel)

        self.preferredQRSize = qrSize

        generateQR(with: qrSize)
    }

    func presentAssetSelection() {
        var initialIndex = 0

        if let assetId = assetSelectionViewModel.assetId {
            initialIndex = account.assets.firstIndex(where: { $0.identifier.identifier() == assetId.identifier() }) ?? 0
        }

        let titles: [String] = account.assets.map { (asset) in
            return assetSelectionFactory.createTitle(for: asset, balanceData: nil)
        }

        coordinator.presentPicker(for: titles, initialIndex: initialIndex, delegate: self)

        assetSelectionViewModel.isSelecting = true
    }
}

extension ReceiveAmountPresenter: AssetSelectionViewModelObserver {
    func assetSelectionDidChangeTitle() {}

    func assetSelectionDidChangeSymbol() {
        if let qrSize = preferredQRSize {
            generateQR(with: qrSize)
        }
    }

    func assetSelectionDidChangeState() {}
}

extension ReceiveAmountPresenter: AmountInputViewModelObserver {
    func amountInputDidChange() {
        if let qrSize = preferredQRSize {
            generateQR(with: qrSize)
        }
    }
}

extension ReceiveAmountPresenter: ModalPickerViewDelegate {
    func modalPickerViewDidCancel(_ view: ModalPickerView) {
        assetSelectionViewModel.isSelecting = false
    }

    func modalPickerView(_ view: ModalPickerView, didSelectRowAt index: Int, in context: AnyObject?) {
        assetSelectionViewModel.isSelecting = false

        let newAsset = account.assets[index]

        assetSelectionViewModel.assetId = newAsset.identifier

        let title = assetSelectionFactory.createTitle(for: newAsset, balanceData: nil)

        assetSelectionViewModel.title = title

        assetSelectionViewModel.symbol = newAsset.symbol
    }

    func close() {
        coordinator.close()
    }
}
