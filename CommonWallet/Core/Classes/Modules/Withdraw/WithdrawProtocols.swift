/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation

protocol WithdrawViewProtocol: OperationDefinitionViewProtocol, ControllerBackedProtocol,
LoadableViewProtocol, AlertPresentable {}

protocol WithdrawCoordinatorProtocol: CoordinatorProtocol, PickerPresentable {
    func confirm(with info: WithdrawInfo, asset: WalletAsset, option: WalletWithdrawOption)
}

protocol WithdrawAssemblyProtocol: class {
    static func assembleView(with resolver: ResolverProtocol,
                             asset: WalletAsset,
                             option: WalletWithdrawOption) -> WithdrawViewProtocol?
}
