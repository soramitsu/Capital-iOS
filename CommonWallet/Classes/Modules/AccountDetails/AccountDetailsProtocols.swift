/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

protocol AccountDetailsViewProtocol: ControllerBackedProtocol {}


protocol AccountDetailsPresenterProtocol: class {
    func setup()
}


protocol AccountDetailsCoordinatorProtocol: class {}


protocol AccountDetailsAssemblyProtocol: class {
    static func assembleView(with resolver: ResolverProtocol, asset: WalletAsset) -> AccountDetailsViewProtocol?
}
