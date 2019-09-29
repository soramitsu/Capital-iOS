/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

protocol TransactionDetailsPresenterProtocol: WalletFormPresenterProtocol {}


protocol TransactionDetailsCoordinatorProtocol: class {
    func send(to payload: AmountPayload)
}


protocol TransactionDetailsAssemblyProtocol: class {
	static func assembleView(resolver: ResolverProtocol, transactionDetails: AssetTransactionData)
        -> WalletFormViewProtocol?
}
