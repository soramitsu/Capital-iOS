protocol WalletFormViewProtocol: ControllerBackedProtocol, LoadableViewProtocol, AlertPresentable {
    func didReceive(viewModels: [WalletFormViewModelProtocol])
    func didReceive(accessoryViewModel: AccessoryViewModelProtocol?)
}


protocol WalletFormPresenterProtocol: class {
    func setup()
    func performAction()
}
