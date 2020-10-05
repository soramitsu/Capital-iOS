/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol OperationDefinitionHeaderViewProtocol {
    func bind(viewModel: MultilineTitleIconViewModelProtocol)
}

public typealias BaseOperationDefinitionHeaderView = UIView & OperationDefinitionHeaderViewProtocol

extension MultilineTitleIconView: OperationDefinitionHeaderViewProtocol {}
