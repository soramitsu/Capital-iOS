protocol TransferResultPresenterProtocol: WalletFormPresenterProtocol {
    func setup()
}


protocol TransferResultCoordinatorProtocol: class {
    func dismiss()
}


protocol TransferResultAssemblyProtocol: class {
    static func assembleView(resolver: ResolverProtocol, transferPayload: TransferPayload) -> WalletFormViewProtocol?
}
