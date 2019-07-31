/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */


protocol WithdrawAmountViewProtocol: ControllerBackedProtocol, LoadableViewProtocol, AlertPresentable {
    func set(title: String)
    func set(assetViewModel: AssetSelectionViewModelProtocol)
    func set(amountViewModel: AmountInputViewModelProtocol)
    func set(descriptionViewModel: DescriptionInputViewModelProtocol)
    func set(feeViewModel: WithdrawFeeViewModelProtocol)
    func didChange(accessoryViewModel: AccessoryViewModelProtocol)
}


protocol WithdrawAmountPresenterProtocol: class {
    func setup()
    func confirm()
    func presentAssetSelection()
}


protocol WithdrawAmountCoordinatorProtocol: CoordinatorProtocol, PickerPresentable {}


protocol WithdrawAmountAssemblyProtocol: class {
    static func assembleView(with resolver: ResolverProtocol, payload: WithdrawPayload) -> WithdrawAmountViewProtocol?
}
