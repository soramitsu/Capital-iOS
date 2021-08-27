/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

protocol WithdrawConfirmationPresenterProtocol: WalletFormPresenterProtocol {}

protocol WithdrawConfirmationCoordinatorProtocol: AnyObject {
    func showResult(for withdrawInfo: WithdrawInfo,
                    asset: WalletAsset,
                    option: WalletWithdrawOption)
}

protocol WithdrawConfirmationAssemblyProtocol: AnyObject {
    static func assembleView(for resolver: ResolverProtocol,
                             info: WithdrawInfo,
                             asset: WalletAsset,
                             option: WalletWithdrawOption) -> WalletFormViewProtocol?
}
