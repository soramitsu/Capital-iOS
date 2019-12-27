/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraUI
import SoraFoundation

protocol ContactsConfigurationProtocol {
    var contactCellStyle: ContactCellStyleProtocol { get }
    var viewStyle: ContactsViewStyleProtocol { get }
    var sendOptionStyle: SendOptionCellStyleProtocol { get }
    var sectionStyle: WalletTextStyleProtocol { get }
    var searchPlaceholder: LocalizableResource<String> { get }
    var contactsEmptyStateDataSource: EmptyStateDataSource? { get }
    var contactsEmptyStateDelegate: EmptyStateDelegate? { get }
    var searchEmptyStateDataSource: EmptyStateDataSource? { get }
    var searchEmptyStateDelegate: EmptyStateDelegate? { get }
    var supportsLiveSearch: Bool { get }
}


struct ContactsConfiguration: ContactsConfigurationProtocol {
    var contactCellStyle: ContactCellStyleProtocol
    var viewStyle: ContactsViewStyleProtocol
    var sendOptionStyle: SendOptionCellStyleProtocol
    var sectionStyle: WalletTextStyleProtocol
    var searchPlaceholder: LocalizableResource<String>
    var contactsEmptyStateDataSource: EmptyStateDataSource?
    weak var contactsEmptyStateDelegate: EmptyStateDelegate?
    var searchEmptyStateDataSource: EmptyStateDataSource?
    weak var searchEmptyStateDelegate: EmptyStateDelegate?
    var supportsLiveSearch: Bool
}
