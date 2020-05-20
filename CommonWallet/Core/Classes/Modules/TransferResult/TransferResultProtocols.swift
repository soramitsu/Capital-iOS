/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

protocol TransferResultPresenterProtocol: WalletFormPresenterProtocol {
    func setup()
}


protocol TransferResultCoordinatorProtocol: class {
    func dismiss()
}


protocol TransferResultAssemblyProtocol: class {
    static func assembleView(resolver: ResolverProtocol,
                             payload: ConfirmationPayload) -> WalletFormViewProtocol?
}
