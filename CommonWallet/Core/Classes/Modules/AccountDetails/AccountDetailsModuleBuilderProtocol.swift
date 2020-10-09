/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraFoundation

public protocol AccountDetailsModuleBuilderProtocol {
    @discardableResult
    func with(containingViewFactory: AccountDetailsContainingViewFactoryProtocol) -> Self

    @discardableResult
    func with(listViewModelFactory: AccountListViewModelFactoryProtocol) -> Self

    @discardableResult
    func with(localizableTitle: LocalizableResource<String>) -> Self

    @discardableResult
    func with(additionalInsets: UIEdgeInsets) -> Self
}
