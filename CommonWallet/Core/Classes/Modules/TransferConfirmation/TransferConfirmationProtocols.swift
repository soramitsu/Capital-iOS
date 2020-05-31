/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

protocol TransferConfirmationPresenterProtocol: WalletNewFormPresenterProtocol {}


protocol TransferConfirmationCoordinatorProtocol: class {
    func showResult(payload: ConfirmationPayload)
}


protocol TransferConfirmationAssemblyProtocol: class {
	static func assembleView(with resolver: ResolverProtocol, payload: ConfirmationPayload)
        -> WalletNewFormViewProtocol?
}
