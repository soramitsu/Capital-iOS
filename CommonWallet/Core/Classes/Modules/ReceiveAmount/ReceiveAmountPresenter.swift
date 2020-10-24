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
    private(set) var assets: [WalletAsset]
    private(set) var accountId: String
    private(set) var amountInputViewModel: AmountInputViewModel?
    private(set) var descriptionViewModel: DescriptionInputViewModel?
    private(set) var preferredQRSize: CGSize?
    private(set) var selectedAsset: WalletAsset
    private(set) var viewModelFactory: ReceiveViewModelFactoryProtocol
    private(set) var fieldsInclusion: ReceiveFieldsInclusion

    private var currentImage: UIImage?

    var logger: WalletLoggerProtocol?

    private var qrOperation: Operation?

    deinit {
        cancelQRGeneration()
    }

    init(view: ReceiveAmountViewProtocol,
         coordinator: ReceiveAmountCoordinatorProtocol,
         assets: [WalletAsset],
         accountId: String,
         qrService: WalletQRServiceProtocol,
         sharingFactory: AccountShareFactoryProtocol,
         receiveInfo: ReceiveInfo,
         viewModelFactory: ReceiveViewModelFactoryProtocol,
         fieldsInclusion: ReceiveFieldsInclusion,
         localizationManager: LocalizationManagerProtocol?) throws {
        self.view = view
        self.coordinator = coordinator
        self.qrService = qrService
        self.sharingFactory = sharingFactory
        self.assets = assets
        self.accountId = accountId
        self.viewModelFactory = viewModelFactory
        self.fieldsInclusion = fieldsInclusion

        var currentAmount: Decimal?

        if
            let assetId = receiveInfo.assetId,
            let asset = assets.first(where: { $0.identifier == assetId}) {
            selectedAsset = asset

            if let amount = receiveInfo.amount {
                currentAmount = amount.decimalValue
            }
        } else {
            selectedAsset = assets[0]
        }

        if fieldsInclusion.contains(.amount) {
            let locale = localizationManager?.selectedLocale ?? Locale.current

            amountInputViewModel = viewModelFactory.createAmountViewModel(for: selectedAsset,
                                                                          amount: currentAmount,
                                                                          locale: locale)
        }

        if fieldsInclusion.contains(.description) {
            descriptionViewModel = try viewModelFactory
                .createDescriptionViewModel(for: receiveInfo.details)
        }

        self.localizationManager = localizationManager
    }

    private func setupSelectedAssetViewModel(isSelecting: Bool) {
        guard fieldsInclusion.contains(.selectedAsset) else {
            return
        }

        let locale = localizationManager?.selectedLocale ?? Locale.current

        let state = SelectedAssetState(isSelecting: isSelecting,
                                       canSelect: assets.count > 1)

        let viewModel = viewModelFactory.createSelectedAssetViewModel(for: selectedAsset,
                                                                      balanceData: nil,
                                                                      selectedAssetState: state,
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

        if let decimalAmount = amountInputViewModel?.decimalAmount, decimalAmount > 0 {
            amount = AmountDecimal(value: decimalAmount)
        }

        return ReceiveInfo(accountId: accountId,
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
        guard let amountInputViewModel = amountInputViewModel else {
            return
        }

        let locale = localizationManager?.selectedLocale ?? Locale.current
        let amount = amountInputViewModel.decimalAmount

        amountInputViewModel.observable.remove(observer: self)

        let newViewModel = viewModelFactory.createAmountViewModel(for: selectedAsset,
                                                                  amount: amount,
                                                                  locale: locale)
        self.amountInputViewModel = newViewModel

        newViewModel.observable.add(observer: self)

        view?.didReceive(amountInputViewModel: newViewModel)
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

        if let amountInputViewModel = amountInputViewModel {
            amountInputViewModel.observable.remove(observer: self)
            amountInputViewModel.observable.add(observer: self)

            view?.didReceive(amountInputViewModel: amountInputViewModel)
        }

        if let descriptionViewModel = descriptionViewModel {
            descriptionViewModel.observable.remove(observer: self)
            descriptionViewModel.observable.add(observer: self)

            view?.didReceive(descriptionViewModel: descriptionViewModel)
        }

        self.preferredQRSize = qrSize

        generateQR(with: qrSize)
    }

    func presentAssetSelection() {
        let initialIndex = assets.firstIndex(where: { $0.identifier == selectedAsset.identifier }) ?? 0

        let locale = localizationManager?.selectedLocale ?? Locale.current

        let titles: [String] = assets.map { (asset) in
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
        let newAsset = assets[index]

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
