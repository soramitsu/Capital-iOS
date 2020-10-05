/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol OperationDefinitionErrorViewProtocol {
    func bind(viewModel: MultilineTitleIconViewModelProtocol)
}

public typealias BaseOperationDefinitionErrorView = UIView & OperationDefinitionErrorViewProtocol

extension ContainingErrorView: OperationDefinitionErrorViewProtocol {}
