/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

protocol WalletFormViewProtocol: ControllerBackedProtocol, LoadableViewProtocol, AlertPresentable {
    func didReceive(viewModels: [WalletFormViewModelProtocol])
    func didReceive(accessoryViewModel: AccessoryViewModelProtocol?)
}


protocol WalletFormPresenterProtocol: AnyObject {
    func setup()
    func performAction()
}
