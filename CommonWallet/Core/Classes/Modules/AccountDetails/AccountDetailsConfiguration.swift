/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraFoundation

protocol AccountDetailsConfigurationProtocol {
    var containingViewFactory: AccountDetailsContainingViewFactoryProtocol? { get }
    var listViewModelFactory: AccountListViewModelFactoryProtocol? { get }
    var localizableTitle: LocalizableResource<String>? { get }
    var additionalInsets: UIEdgeInsets { get }
}

struct AccountDetailsConfiguration: AccountDetailsConfigurationProtocol {
    let containingViewFactory: AccountDetailsContainingViewFactoryProtocol?
    let listViewModelFactory: AccountListViewModelFactoryProtocol?
    let localizableTitle: LocalizableResource<String>?
    let additionalInsets: UIEdgeInsets
}
