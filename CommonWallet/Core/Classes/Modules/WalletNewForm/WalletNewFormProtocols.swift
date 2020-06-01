/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

protocol WalletNewFormViewProtocol: ControllerBackedProtocol, LoadableViewProtocol, AlertPresentable {
    func didReceive(viewModels: [WalletFormViewBindingProtocol])
    func didReceive(accessoryViewModel: AccessoryViewModelProtocol?)
}


protocol WalletNewFormPresenterProtocol: class {
    func setup()
    func performAction()
}
