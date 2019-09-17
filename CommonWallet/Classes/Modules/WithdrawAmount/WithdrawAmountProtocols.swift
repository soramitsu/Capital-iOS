/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import IrohaCommunication

protocol WithdrawAmountViewProtocol: ControllerBackedProtocol, LoadableViewProtocol, AlertPresentable {
    func set(title: String)
    func set(assetViewModel: AssetSelectionViewModelProtocol)
    func set(amountViewModel: AmountInputViewModelProtocol)
    func set(descriptionViewModel: DescriptionInputViewModelProtocol)
    func set(feeViewModel: FeeViewModelProtocol)
    func didChange(accessoryViewModel: AccessoryViewModelProtocol)
}


protocol WithdrawAmountPresenterProtocol: class {
    func setup()
    func confirm()
    func presentAssetSelection()
}


protocol WithdrawAmountCoordinatorProtocol: CoordinatorProtocol, PickerPresentable {
    func confirm(with info: WithdrawInfo, asset: WalletAsset, option: WalletWithdrawOption)
}


protocol WithdrawAmountAssemblyProtocol: class {
    static func assembleView(with resolver: ResolverProtocol,
                             asset: WalletAsset,
                             option: WalletWithdrawOption) -> WithdrawAmountViewProtocol?
}
