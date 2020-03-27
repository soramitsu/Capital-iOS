/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

protocol ContactsViewProtocol: ControllerBackedProtocol, AlertPresentable {
    
    func set(viewModel: ContactListViewModelProtocol)
    func didStartSearch()
    func didStopSearch()
}


protocol ContactsPresenterProtocol: class {

    func setup()
    func search(_ pattern: String)

}


protocol ContactsCoordinatorProtocol: class {
    
    func send(to payload: AmountPayload)
    func scanInvoice()
    
}


protocol ContactsAssemblyProtocol: class {
    
    static func assembleView(with resolver: ResolverProtocol,
                             selectedAsset: WalletAsset) -> ContactsViewProtocol?
    
}
