protocol ConfirmationPresenterProtocol: WalletFormPresenterProtocol {}


protocol ConfirmationCoordinatorProtocol: class {
    func showResult(payload: TransferPayload)
}


protocol ConfirmationAssemblyProtocol: class {
	static func assembleView(with resolver: ResolverProtocol, payload: TransferPayload) -> WalletFormViewProtocol?
}
