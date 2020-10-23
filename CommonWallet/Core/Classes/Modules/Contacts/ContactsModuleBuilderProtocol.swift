/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraUI
import SoraFoundation

public protocol ContactsModuleBuilderProtocol: class {

    @discardableResult
    func with<Cell>(cellClass: Cell.Type?,
                    for reuseIdentifier: String) -> Self where Cell: UITableViewCell & WalletViewProtocol

    @discardableResult
    func with(cellNib: UINib?, for reuseIdentifier: String) -> Self

    @discardableResult
    func with(listViewModelFactory: ContactsListViewModelFactoryProtocol) -> Self

    @discardableResult
    func with(viewModelFactoryWrapper: ContactsFactoryWrapperProtocol) -> Self

    @discardableResult
    func with(actionFactoryWrapper: ContactsActionFactoryWrapperProtocol) -> Self

    @discardableResult
    func with(localSearchEngine: ContactsLocalSearchEngineProtocol) -> Self

    @discardableResult
    func with(contactCellStyle: ContactCellStyleProtocol) -> Self

    @discardableResult
    func with(sendOptionCellStyle: SendOptionCellStyleProtocol) -> Self
    
    @discardableResult
    func with(viewStyle: ContactsViewStyleProtocol) -> Self
    
    @discardableResult
    func with(sectionHeaderStyle: ContactsSectionStyleProtocol) -> Self

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

    @discardableResult
    func with(canFindItself: Bool) -> Self

    @discardableResult
    func with(scanPosition: WalletContactsScanPosition) -> Self

    @discardableResult
    func with(withdrawOptionsPosition: WalletContactsWithdrawPosition) -> Self
}
