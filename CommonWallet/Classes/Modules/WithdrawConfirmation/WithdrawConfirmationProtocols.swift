protocol WithdrawConfirmationPresenterProtocol: WalletFormPresenterProtocol {}

protocol WithdrawConfirmationCoordinatorProtocol: class {
    func showResult(for withdrawInfo: WithdrawInfo,
                    asset: WalletAsset,
                    option: WalletWithdrawOption)
}

protocol WithdrawConfirmationAssemblyProtocol: class {
    static func assembleView(for resolver: ResolverProtocol,
                             info: WithdrawInfo,
                             asset: WalletAsset,
                             option: WalletWithdrawOption) -> WalletFormViewProtocol?
}
