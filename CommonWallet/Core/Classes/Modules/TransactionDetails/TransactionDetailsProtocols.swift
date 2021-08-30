/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

protocol TransactionDetailsPresenterProtocol: WalletNewFormPresenterProtocol {}


protocol TransactionDetailsCoordinatorProtocol: AnyObject {
    func send(to payload: TransferPayload)
}


protocol TransactionDetailsAssemblyProtocol: AnyObject {
	static func assembleView(resolver: ResolverProtocol, transactionDetails: AssetTransactionData)
        -> WalletNewFormViewProtocol?
}
