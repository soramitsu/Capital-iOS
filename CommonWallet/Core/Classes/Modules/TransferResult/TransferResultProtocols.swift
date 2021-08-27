/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

protocol TransferResultPresenterProtocol: WalletFormPresenterProtocol {
    func setup()
}


protocol TransferResultCoordinatorProtocol: AnyObject {
    func dismiss()
}


protocol TransferResultAssemblyProtocol: AnyObject {
    static func assembleView(resolver: ResolverProtocol,
                             payload: ConfirmationPayload) -> WalletFormViewProtocol?
}
