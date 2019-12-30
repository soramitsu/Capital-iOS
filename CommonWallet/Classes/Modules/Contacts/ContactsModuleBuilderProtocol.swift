/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraUI
import SoraFoundation

public protocol ContactsModuleBuilderProtocol: class {
    
    @discardableResult
    func with(contactCellStyle: ContactCellStyleProtocol) -> Self

    @discardableResult
    func with(sendOptionCellStyle: SendOptionCellStyleProtocol) -> Self
    
    @discardableResult
    func with(viewStyle: ContactsViewStyleProtocol) -> Self
    
    @discardableResult
    func with(sectionHeaderStyle: WalletTextStyleProtocol) -> Self

    @discardableResult
    func with(searchPlaceholder: LocalizableResource<String>) -> Self

    @discardableResult
    func with(contactsEmptyStateDataSource: EmptyStateDataSource) -> Self

    @discardableResult
    func with(contactsEmptyStateDelegate: EmptyStateDelegate) -> Self

    @discardableResult
    func with(searchEmptyStateDataSource: EmptyStateDataSource) -> Self

    @discardableResult
    func with(searchEmptyStateDelegate: EmptyStateDelegate) -> Self

    @discardableResult
    func with(supportsLiveSearch: Bool) -> Self
}
