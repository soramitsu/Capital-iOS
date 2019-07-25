protocol TransactionDetailsPresenterProtocol: WalletFormPresenterProtocol {}


protocol TransactionDetailsCoordinatorProtocol: class {}


protocol TransactionDetailsAssemblyProtocol: class {
	static func assembleView(resolver: ResolverProtocol, transactionDetails: AssetTransactionData)
        -> WalletFormViewProtocol?
}
