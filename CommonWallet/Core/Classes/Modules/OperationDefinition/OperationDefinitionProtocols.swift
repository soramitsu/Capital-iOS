/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

protocol OperationDefinitionViewProtocol: class {
    func setAssetHeader(_ viewModel: MultilineTitleIconViewModelProtocol?)
    func set(assetViewModel: AssetSelectionViewModelProtocol)
    func presentAssetError(_ message: String?)

    func setAmountHeader(_ viewModel: MultilineTitleIconViewModelProtocol?)
    func set(amountViewModel: AmountInputViewModelProtocol)
    func presentAmountError(_ message: String?)

    func setReceiverHeader(_ viewModel: MultilineTitleIconViewModelProtocol?)
    func set(receiverViewModel: MultilineTitleIconViewModelProtocol)
    func presentReceiverError(_ message: String?)

    func setDescriptionHeader(_ viewModel: MultilineTitleIconViewModelProtocol?)
    func set(descriptionViewModel: DescriptionInputViewModelProtocol)
    func presentDescriptionError(_ message: String?)

    func setFeeHeader(_ viewModel: MultilineTitleIconViewModelProtocol?, at index: Int)
    func set(feeViewModels: [FeeViewModelProtocol])
    func presentFeeError(_ message: String?, at index: Int)

    func set(accessoryViewModel: AccessoryViewModelProtocol)
}

protocol OperationDefinitionPresenterProtocol: class {
    func setup()
    func presentAssetSelection()
    func presentFeeEditing(at index: Int)
    func proceed()
}
