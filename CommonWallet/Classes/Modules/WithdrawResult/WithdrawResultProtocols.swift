/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

protocol WithdrawResultPresenterProtocol: WalletFormPresenterProtocol {}

protocol WithdrawResultCoordinatorProtocol: class {
    func dismiss()
}

protocol WithdrawResultAssemblyProtocol: class {
    static func assembleView(for resolver: ResolverProtocol,
                             info: WithdrawInfo,
                             asset: WalletAsset,
                             option: WalletWithdrawOption) -> WalletFormViewProtocol?
}
