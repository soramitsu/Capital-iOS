/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraUI
import SoraFoundation

protocol ContactsConfigurationProtocol {
    var viewModelFactoryWrapper: ContactsFactoryWrapperProtocol? { get }
    var cellStyle: ContactsCellStyle { get }
    var viewStyle: ContactsViewStyleProtocol { get }
    var sectionStyle: WalletTextStyleProtocol { get }
    var searchPlaceholder: LocalizableResource<String> { get }
    var contactsEmptyStateDataSource: EmptyStateDataSource? { get }
    var contactsEmptyStateDelegate: EmptyStateDelegate? { get }
    var searchEmptyStateDataSource: EmptyStateDataSource? { get }
    var searchEmptyStateDelegate: EmptyStateDelegate? { get }
    var scanPosition: WalletContactsScanPosition { get }
    var withdrawOptionsPosition: WalletContactsWithdrawPosition { get }
    var supportsLiveSearch: Bool { get }
}


struct ContactsConfiguration: ContactsConfigurationProtocol {
    var viewModelFactoryWrapper: ContactsFactoryWrapperProtocol?
    var cellStyle: ContactsCellStyle
    var viewStyle: ContactsViewStyleProtocol
    var sectionStyle: WalletTextStyleProtocol
    var searchPlaceholder: LocalizableResource<String>
    var contactsEmptyStateDataSource: EmptyStateDataSource?
    weak var contactsEmptyStateDelegate: EmptyStateDelegate?
    var searchEmptyStateDataSource: EmptyStateDataSource?
    weak var searchEmptyStateDelegate: EmptyStateDelegate?
    var scanPosition: WalletContactsScanPosition
    var withdrawOptionsPosition: WalletContactsWithdrawPosition
    var supportsLiveSearch: Bool
}
