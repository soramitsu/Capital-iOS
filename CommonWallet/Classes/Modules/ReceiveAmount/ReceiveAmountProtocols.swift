/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

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
    static func assembleView(resolver: ResolverProtocol,
                             selectedAsset: WalletAsset) -> ReceiveAmountViewProtocol?
}
