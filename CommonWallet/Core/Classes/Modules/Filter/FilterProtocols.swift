/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

typealias FilterViewModel = [WalletViewModelProtocol]
typealias FilterSelectionAction = ((Int) -> Void)


protocol Filterable {
    
    func set(filter: WalletHistoryRequest)
    
}


protocol FilterViewCellProtocol: WalletViewProtocol {
    
    func applyStyle(_ style: WalletStyleProtocol)
    
}


protocol FilterViewProtocol: ControllerBackedProtocol {

    func set(filter: FilterViewModel)

}


protocol FilterPresenterProtocol: class {
    
    func setup()
    func reset()
    func apply()
}


protocol FilterCoordinatorProtocol: CoordinatorProtocol, PickerPresentable {}


protocol FilterAssemblyProtocol: class {

    static func assembleView(with resolver: ResolverProtocol,
                             assets: [WalletAsset],
                             filtering: Filterable,
                             filter: WalletHistoryRequest?) -> FilterViewProtocol?
}
