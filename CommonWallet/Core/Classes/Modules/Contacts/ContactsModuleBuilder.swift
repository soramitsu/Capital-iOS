/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Contacts
import SoraUI
import SoraFoundation

enum ContactsModuleBuilderError: Error {
    case contactIsInvalidError
}


final class ContactsModuleBuilder {

    lazy var walletStyle: WalletStyleProtocol = WalletStyle()
    
    fileprivate lazy var contactStyle: ContactCellStyleProtocol = {
        return ContactCellStyle.createDefaultStyle(with: walletStyle)
    }()

    fileprivate lazy var sendOptionStyle: SendOptionCellStyleProtocol = {
        return SendOptionCellStyle.createDefaultStyle(with: walletStyle)
    }()
    
    fileprivate lazy var viewStyle: ContactsViewStyleProtocol = {
        return ContactsViewStyle.createDefaultStyle(with: walletStyle)
    }()
    
    fileprivate lazy var sectionStyle: ContactsSectionStyleProtocol = {
        return ContactsSectionStyle.createDefaultStyle(with: walletStyle)
    }()

    fileprivate weak var contactsEmptyStateDelegate: EmptyStateDelegate?
    fileprivate var contactsEmptyStateDataSource: EmptyStateDataSource?

    fileprivate weak var searchEmptyStateDelegate: EmptyStateDelegate?
    fileprivate var searchEmptyStateDataSource: EmptyStateDataSource?

    fileprivate var searchPlaceholder: LocalizableResource<String> = LocalizableResource { _ in L10n.Common.search }

    fileprivate var supportsLiveSearch: Bool = false

    fileprivate var scanPosition: WalletContactsScanPosition = .tableAction

    fileprivate var withdrawOptionsPosition: WalletContactsWithdrawPosition = .tableAction

    fileprivate var listViewModelFactory: ContactsListViewModelFactoryProtocol?

    fileprivate var viewModelFactoryWrapper: ContactsFactoryWrapperProtocol?

    fileprivate var actionFactoryWrapper: ContactsActionFactoryWrapperProtocol?

    fileprivate var localSearchEngine: ContactsLocalSearchEngineProtocol?

    fileprivate var canFindItself: Bool = false

    fileprivate var registeredCellMetadata = [String: Any]()

    init() {
        registerContactCell()
        registerSendOptionsCell()
    }

    private func registerContactCell() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ContactCell", bundle: bundle)
        registeredCellMetadata[ContactConstants.contactCellIdentifier] = nib
    }

    private func registerSendOptionsCell() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "SendOptionCell", bundle: bundle)
        registeredCellMetadata[ContactConstants.optionCellIdentifier] = nib
    }

    func build() -> ContactsConfigurationProtocol {
        let cellStyle = ContactsCellStyle(contactStyle: contactStyle, sendOptionStyle: sendOptionStyle)
        return ContactsConfiguration(registeredCellMetadata: registeredCellMetadata,
                                     cellStyle: cellStyle,
                                     viewStyle: viewStyle,
                                     sectionStyle: sectionStyle,
                                     searchPlaceholder: searchPlaceholder,
                                     contactsEmptyStateDataSource: contactsEmptyStateDataSource,
                                     contactsEmptyStateDelegate: contactsEmptyStateDelegate,
                                     searchEmptyStateDataSource: searchEmptyStateDataSource,
                                     searchEmptyStateDelegate: searchEmptyStateDelegate,
                                     scanPosition: scanPosition,
                                     withdrawOptionsPosition: withdrawOptionsPosition,
                                     supportsLiveSearch: supportsLiveSearch,
                                     canFindItself: canFindItself,
                                     viewModelFactoryWrapper: viewModelFactoryWrapper,
                                     actionFactoryWrapper: actionFactoryWrapper,
                                     listViewModelFactory: listViewModelFactory,
                                     localSearchEngine: localSearchEngine)
    }
    
}


extension ContactsModuleBuilder: ContactsModuleBuilderProtocol {

    @discardableResult
    func with(listViewModelFactory: ContactsListViewModelFactoryProtocol) -> Self {
        self.listViewModelFactory = listViewModelFactory
        return self
    }

    func with(viewModelFactoryWrapper: ContactsFactoryWrapperProtocol) -> Self {
        self.viewModelFactoryWrapper = viewModelFactoryWrapper
        return self
    }

    func with(actionFactoryWrapper: ContactsActionFactoryWrapperProtocol) -> Self {
        self.actionFactoryWrapper = actionFactoryWrapper
        return self
    }

    func with(localSearchEngine: ContactsLocalSearchEngineProtocol) -> Self {
        self.localSearchEngine = localSearchEngine
        return self
    }

    func with(contactCellStyle: ContactCellStyleProtocol) -> Self {
        self.contactStyle = contactCellStyle
        return self
    }

    func with(sendOptionCellStyle: SendOptionCellStyleProtocol) -> Self {
        self.sendOptionStyle = sendOptionStyle
        return self
    }
    
    func with(viewStyle: ContactsViewStyleProtocol) -> Self {
        self.viewStyle = viewStyle
        return self
    }
    
    func with(sectionHeaderStyle: ContactsSectionStyleProtocol) -> Self {
        self.sectionStyle = sectionHeaderStyle
        return self
    }

    func with(searchPlaceholder: LocalizableResource<String>) -> Self {
        self.searchPlaceholder = searchPlaceholder
        return self
    }

    func with(contactsEmptyStateDataSource: EmptyStateDataSource) -> Self {
        self.contactsEmptyStateDataSource = contactsEmptyStateDataSource
        return self
    }

    func with(contactsEmptyStateDelegate: EmptyStateDelegate) -> Self {
        self.contactsEmptyStateDelegate = contactsEmptyStateDelegate
        return self
    }

    func with(searchEmptyStateDataSource: EmptyStateDataSource) -> Self {
        self.searchEmptyStateDataSource = searchEmptyStateDataSource
        return self
    }

    func with(searchEmptyStateDelegate: EmptyStateDelegate) -> Self {
        self.searchEmptyStateDelegate = searchEmptyStateDelegate
        return self
    }

    func with(scanPosition: WalletContactsScanPosition) -> Self {
        self.scanPosition = scanPosition
        return self
    }

    func with(withdrawOptionsPosition: WalletContactsWithdrawPosition) -> Self {
        self.withdrawOptionsPosition = withdrawOptionsPosition
        return self
    }

    func with(supportsLiveSearch: Bool) -> Self {
        self.supportsLiveSearch = supportsLiveSearch
        return self
    }

    func with(canFindItself: Bool) -> Self {
        self.canFindItself = canFindItself
        return self
    }

    func with<Cell>(cellClass: Cell.Type?,
                    for reuseIdentifier: String) -> Self where Cell: UITableViewCell & WalletViewProtocol {
        registeredCellMetadata[reuseIdentifier] = cellClass
        return self
    }

    func with(cellNib: UINib?, for reuseIdentifier: String) -> Self {
        registeredCellMetadata[reuseIdentifier] = cellNib
        return self
    }
}
