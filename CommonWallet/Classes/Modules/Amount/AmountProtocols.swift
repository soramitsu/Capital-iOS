/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

protocol AmountViewProtocol: ControllerBackedProtocol, LoadableViewProtocol, AlertPresentable {
    func set(assetViewModel: AssetSelectionViewModelProtocol)
    func set(amountViewModel: AmountInputViewModelProtocol)
    func set(descriptionViewModel: DescriptionInputViewModelProtocol)
    func set(accessoryViewModel: AccessoryViewModelProtocol)
    func set(feeViewModel: FeeViewModelProtocol)
}


protocol AmountPresenterProtocol: class {
    func setup()
    func confirm()
    func presentAssetSelection()
    func close()
}


protocol AmountCoordinatorProtocol: CoordinatorProtocol, PickerPresentable {
    func confirm(with payload: TransferPayload)
    func close()
}


protocol AmountAssemblyProtocol: class {
    static func assembleView(with resolver: ResolverProtocol,
                             payload: AmountPayload) -> AmountViewProtocol?
}
