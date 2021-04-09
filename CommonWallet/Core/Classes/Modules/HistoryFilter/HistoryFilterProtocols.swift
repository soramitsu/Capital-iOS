/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

typealias HistoryFilterViewModel = [WalletViewModelProtocol]
typealias HistoryFilterSelectionAction = (Int) -> Void

protocol HistoryFilterViewCellProtocol: WalletViewProtocol {
    func applyStyle(_ style: WalletStyleProtocol)
}

protocol HistoryFilterViewProtocol: ControllerBackedProtocol {
    func set(filter: HistoryFilterViewModel)
}

protocol HistoryFilterPresenterProtocol: class {
    func setup()
    func reset()
    func apply()
}

protocol HistoryFilterCoordinatorProtocol: CoordinatorProtocol, PickerPresentable {}

protocol HistoryFilterAssemblyProtocol: class {
    static func assembleView(with resolver: ResolverProtocol,
                             assets: [WalletAsset],
                             delegate: HistoryFilterEditingDelegate?,
                             filter: WalletHistoryRequest) -> HistoryFilterViewProtocol?
}
