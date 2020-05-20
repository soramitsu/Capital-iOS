/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

protocol ConfirmationPresenterProtocol: WalletFormPresenterProtocol {}


protocol ConfirmationCoordinatorProtocol: class {
    func showResult(payload: ConfirmationPayload)
}


protocol ConfirmationAssemblyProtocol: class {
	static func assembleView(with resolver: ResolverProtocol, payload: ConfirmationPayload)
        -> WalletFormViewProtocol?
}
