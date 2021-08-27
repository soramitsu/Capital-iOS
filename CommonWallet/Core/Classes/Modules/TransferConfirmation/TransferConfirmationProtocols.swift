/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

protocol TransferConfirmationPresenterProtocol: WalletNewFormPresenterProtocol {}


protocol TransferConfirmationCoordinatorProtocol: AnyObject {
    func proceed(payload: ConfirmationPayload)
}


protocol TransferConfirmationAssemblyProtocol: AnyObject {
	static func assembleView(with resolver: ResolverProtocol, payload: ConfirmationPayload)
        -> WalletNewFormViewProtocol?
}
