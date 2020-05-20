/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood
import SoraFoundation

final class ReceiveAmountPresenter {
    weak var view: ReceiveAmountViewProtocol?
    var coordinator: ReceiveAmountCoordinatorProtocol

    private(set) var qrService: WalletQRServiceProtocol
    private(set) var sharingFactory: AccountShareFactoryProtocol
    private(set) var account: WalletAccountSettingsProtocol
    private(set) var amountInputViewModel: AmountInputViewModel
    private(set) var descriptionViewModel: DescriptionInputViewModel?
    private(set) var preferredQRSize: CGSize?
    private(set) var selectedAsset: WalletAsset
    private(set) var viewModelFactory: ReceiveViewModelFactoryProtocol

    private var currentImage: UIImage?

    var logger: WalletLoggerProtocol?

    private var qrOperation: Operation?

    deinit {
        cancelQRGeneration()
    }

    init(view: ReceiveAmountViewProtocol,
         coordinator: ReceiveAmountCoordinatorProtocol,
         account: WalletAccountSettingsProtocol,
         qrService: WalletQRServiceProtocol,
         sharingFactory: AccountShareFactoryProtocol,
         receiveInfo: ReceiveInfo,
         viewModelFactory: ReceiveViewModelFactoryProtocol,
         shouldIncludeDescription: Bool,
         localizationManager: LocalizationManagerProtocol?) throws {
        self.view = view
        self.coordinator = coordinator
        self.qrService = qrService
        self.sharingFactory = sharingFactory
        self.account = account
        self.viewModelFactory = viewModelFactory

        var currentAmount: Decimal?

        if let assetId = receiveInfo.assetId, let asset = account.asset(for: assetId) {
            selectedAsset = asset

            if let amount = receiveInfo.amount {
                currentAmount = amount.decimalValue
            }
        } else {
            selectedAsset = account.assets[0]
        }

        let locale = localizationManager?.selectedLocale ?? Locale.current

        amountInputViewModel = viewModelFactory.createAmountViewModel(for: selectedAsset,
                                                                      amount: currentAmount,
                                                                      locale: locale)

        if shouldIncludeDescription {
            descriptionViewModel = try viewModelFactory
                .createDescriptionViewModel(for: receiveInfo.details)
        }

        self.localizationManager = localizationManager
    }

    private func setupSelectedAssetViewModel(isSelecting: Bool) {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        let viewModel = viewModelFactory.createSelectedAssetViewModel(for: selectedAsset,
                                                                      balanceData: nil,
                                                                      isSelecting: isSelecting,
                                                                      canSelect: account.assets.count > 1,
                                                                      locale: locale)

        view?.didReceive(assetSelectionViewModel: viewModel)
    }

    // MARK: QR generation

    private func generateQR(with size: CGSize) {
        cancelQRGeneration()

        currentImage = nil

        do {
            guard let receiveInfo = createReceiveInfo() else {
                return
            }

            qrOperation = try qrService.generate(from: receiveInfo, qrSize: size,
                                                 runIn: .main) { [weak self] (operationResult) in
                                                    if let result = operationResult {
                                                        self?.qrOperation = nil
                                                        self?.processOperation(result: result)
                                                    }
            }
        } catch {
            processOperation(result: .failure(error))
        }
    }

    private func createReceiveInfo() -> ReceiveInfo? {

        var amount: AmountDecimal?

        if let decimalAmount = amountInputViewModel.decimalAmount, decimalAmount > 0 {
            amount = AmountDecimal(value: decimalAmount)
        }

        return ReceiveInfo(accountId: account.accountId,
                           assetId: selectedAsset.identifier,
                           amount: amount,
                           details: descriptionViewModel?.text)
    }

    private func cancelQRGeneration() {
        qrOperation?.cancel()
        qrOperation = nil
    }

    private func processOperation(result: Result<UIImage, Error>) {
        switch result {
        case .success(let image):
            currentImage = image
            view?.didReceive(image: image)
        case .failure:
            view?.showError(message: L10n.Receive.errorQrGeneration)
        }
    }

    private func updateAmountInputViewModel() {
        let locale = localizationManager?.selectedLocale ?? Locale.current
        let amount = amountInputViewModel.decimalAmount

        amountInputViewModel.observable.remove(observer: self)

        amountInputViewModel = viewModelFactory.createAmountViewModel(for: selectedAsset,
                                                                      amount: amount,
                                                                      locale: locale)

        amountInputViewModel.observable.add(observer: self)

        view?.didReceive(amountInputViewModel: amountInputViewModel)
    }

    private func updateDescriptionViewModel() {
        guard let descriptionViewModel = descriptionViewModel else {
            return
        }

        do {
            descriptionViewModel.observable.remove(observer: self)

            let text = descriptionViewModel.text
            let newViewModel = try viewModelFactory.createDescriptionViewModel(for: text)
            self.descriptionViewModel = newViewModel

            newViewModel.observable.add(observer: self)

            view?.didReceive(descriptionViewModel: newViewModel)
        } catch {
            logger?.error("Can't update description view model")
        }
    }
}


extension ReceiveAmountPresenter: ReceiveAmountPresenterProtocol {
    func setup(qrSize: CGSize) {

        setupSelectedAssetViewModel(isSelecting: false)

        amountInputViewModel.observable.remove(observer: self)
        amountInputViewModel.observable.add(observer: self)

        view?.didReceive(amountInputViewModel: amountInputViewModel)

        if let descriptionViewModel = descriptionViewModel {
            descriptionViewModel.observable.remove(observer: self)
            descriptionViewModel.observable.add(observer: self)

            view?.didReceive(descriptionViewModel: descriptionViewModel)
        }

        self.preferredQRSize = qrSize

        generateQR(with: qrSize)
    }

    func presentAssetSelection() {
        let initialIndex = account.assets.firstIndex(where: { $0.identifier == selectedAsset.identifier }) ?? 0

        let locale = localizationManager?.selectedLocale ?? Locale.current

        let titles: [String] = account.assets.map { (asset) in
            return viewModelFactory.createAssetSelectionTitle(asset, balanceData: nil, locale: locale)
        }

        coordinator.presentPicker(for: titles, initialIndex: initialIndex, delegate: self)

        setupSelectedAssetViewModel(isSelecting: true)
    }

    func share() {
        if let qrImage = currentImage, let receiveInfo = createReceiveInfo() {
            let sources = sharingFactory.createSources(for: receiveInfo,
                                                       qrImage: qrImage)

            coordinator.share(sources: sources,
                              from: view,
                              with: nil)
        }
    }
}

extension ReceiveAmountPresenter: AmountInputViewModelObserver {
    func amountInputDidChange() {
        if let qrSize = preferredQRSize {
            generateQR(with: qrSize)
        }
    }
}

extension ReceiveAmountPresenter: DescriptionInputViewModelObserver {
    func descriptionInputDidChangeText() {
        if let qrSize = preferredQRSize {
            generateQR(with: qrSize)
        }
    }
}

extension ReceiveAmountPresenter: ModalPickerViewDelegate {
    func modalPickerViewDidCancel(_ view: ModalPickerView) {
        setupSelectedAssetViewModel(isSelecting: false)
    }

    func modalPickerView(_ view: ModalPickerView, didSelectRowAt index: Int, in context: AnyObject?) {
        let newAsset = account.assets[index]

        selectedAsset = newAsset

        setupSelectedAssetViewModel(isSelecting: false)

        updateAmountInputViewModel()

        if let qrSize = preferredQRSize {
            generateQR(with: qrSize)
        }
    }

    func close() {
        coordinator.close()
    }
}

extension ReceiveAmountPresenter: Localizable {
    func applyLocalization() {
        if view?.isSetup == true {
            setupSelectedAssetViewModel(isSelecting: false)
            updateAmountInputViewModel()
            updateDescriptionViewModel()
        }
    }
}
