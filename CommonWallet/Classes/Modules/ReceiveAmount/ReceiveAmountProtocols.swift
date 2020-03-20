/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

protocol ReceiveAmountViewProtocol: ControllerBackedProtocol, AlertPresentable {
    func didReceive(image: UIImage)
    func didReceive(assetSelectionViewModel: AssetSelectionViewModelProtocol)
    func didReceive(amountInputViewModel: AmountInputViewModelProtocol)
    func didReceive(descriptionViewModel: DescriptionInputViewModelProtocol)
}


protocol ReceiveAmountPresenterProtocol: class {
    func setup(qrSize: CGSize)
    func presentAssetSelection()
    func share()
    func close()
}


protocol ReceiveAmountCoordinatorProtocol: CoordinatorProtocol, PickerPresentable, SharingPresentable {
    func close()
}


protocol ReceiveAmountAssemblyProtocol: class {
    static func assembleView(resolver: ResolverProtocol,
                             selectedAsset: WalletAsset) -> ReceiveAmountViewProtocol?
}
