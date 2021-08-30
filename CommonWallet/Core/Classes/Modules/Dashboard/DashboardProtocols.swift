/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

protocol DashboardViewProtocol: ControllerBackedProtocol {}

protocol DashboardPresenterProtocol: AnyObject {
    func reload()
}

protocol DashboardCoordinatorProtocol: AnyObject {}

protocol DashboardAssemblyProtocol: AnyObject {
	static func assembleView(with resolver: ResolverProtocol) -> DashboardViewProtocol?
}
