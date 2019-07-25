protocol ReceiveAmountViewProtocol: ControllerBackedProtocol, AlertPresentable {
    func didReceive(image: UIImage)
    func didReceive(assetSelectionViewModel: AssetSelectionViewModelProtocol)
    func didReceive(amountInputViewModel: AmountInputViewModelProtocol)
}


protocol ReceiveAmountPresenterProtocol: class {
    func setup(qrSize: CGSize)
    func presentAssetSelection()
    func close()
}


protocol ReceiveAmountCoordinatorProtocol: CoordinatorProtocol, PickerPresentable {
    func close()
}


protocol ReceiveAmountAssemblyProtocol: class {
    static func assembleView(resolver: ResolverProtocol) -> ReceiveAmountViewProtocol?
}
