/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

protocol AccountDetailsConfigurationProtocol {
    var containingViewFactory: AccountDetailsContainingViewFactoryProtocol? { get }
    var listViewModelFactory: AccountListViewModelFactoryProtocol? { get }
}

struct AccountDetailsConfiguration: AccountDetailsConfigurationProtocol {
    let containingViewFactory: AccountDetailsContainingViewFactoryProtocol?
    let listViewModelFactory: AccountListViewModelFactoryProtocol?
}
