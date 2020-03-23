/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import IrohaCommunication

protocol WithdrawAmountCoordinatorProtocol: CoordinatorProtocol, PickerPresentable {
    func confirm(with info: WithdrawInfo, asset: WalletAsset, option: WalletWithdrawOption)
}


protocol WithdrawAmountAssemblyProtocol: class {
    static func assembleView(with resolver: ResolverProtocol,
                             asset: WalletAsset,
                             option: WalletWithdrawOption) -> AmountViewProtocol?
}
