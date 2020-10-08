/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol AccountDetailsModuleBuilderProtocol {
    @discardableResult
    func with(containingViewFactory: AccountDetailsContainingViewFactoryProtocol) -> Self

    @discardableResult
    func with(listViewModelFactory: AccountListViewModelFactoryProtocol) -> Self
}
