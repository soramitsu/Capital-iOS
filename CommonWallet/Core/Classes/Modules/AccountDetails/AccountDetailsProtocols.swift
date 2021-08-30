/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

protocol AccountDetailsViewProtocol: ControllerBackedProtocol {}


protocol AccountDetailsPresenterProtocol: AnyObject {
    func setup()
}


protocol AccountDetailsCoordinatorProtocol: AnyObject {}


protocol AccountDetailsAssemblyProtocol: AnyObject {
    static func assembleView(with resolver: ResolverProtocol, asset: WalletAsset) -> AccountDetailsViewProtocol?
}
