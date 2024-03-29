/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

protocol AccountListViewProtocol: ControllerBackedProtocol, Containable {
    func didLoad(viewModels: [WalletViewModelProtocol], collapsingRange: Range<Int>)
    func didCompleteReload()
    func set(expanded: Bool, animated: Bool)
}

protocol AccountListPresenterProtocol: AnyObject {
    func setup()
    func reload()
    func viewDidAppear()
}

protocol AccountListCoordinatorProtocol: AnyObject {}

protocol AccountListAssemblyProtocol: AnyObject {
    static func assembleView(with resolver: ResolverProtocol) -> AccountListViewProtocol?
    static func assembleView(with resolver: ResolverProtocol, detailsAsset: WalletAsset) -> AccountListViewProtocol?
}
