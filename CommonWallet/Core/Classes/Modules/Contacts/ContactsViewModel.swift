/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


enum ContactListError: Error {
    case invalidIndexPath
}


enum ContactListState {
    case full
    case search
}

public protocol ContactSectionViewModelProtocol {
    var title: String? { get }
    var items: [WalletViewModelProtocol] { get }
}

public struct ContactSectionViewModel: ContactSectionViewModelProtocol {
    public let title: String?
    public let items: [WalletViewModelProtocol]

    public init(title: String?, items: [WalletViewModelProtocol]) {
        self.title = title
        self.items = items
    }
}

protocol ContactListViewModelProtocol {
    var contacts: [ContactSectionViewModelProtocol] { get }
    var found: [WalletViewModelProtocol] { get }
    var state: ContactListState { get }
    var isEmpty: Bool { get }
    var shouldDisplayEmptyState: Bool { get }
    var numberOfSections: Int { get }
    
    func numberOfItems(in section: Int) -> Int
    func title(for section: Int) -> String?
    
    subscript(indexPath: IndexPath) -> WalletViewModelProtocol? { get }
    
}

struct ContactListViewModel: ContactListViewModelProtocol {
    var contacts: [ContactSectionViewModelProtocol]
    var found: [WalletViewModelProtocol]
    var state: ContactListState = .full
    var shouldDisplayEmptyState: Bool = false

    var isEmpty: Bool {
        switch state {
        case .full:
            return contacts.isEmpty
        case .search:
            return found.isEmpty
        }
    }
    
    var numberOfSections: Int {
        switch state {
        case .full:
            return contacts.count
        case .search:
            return 1
        }
    }
    
    init() {
        contacts = []
        found = []
    }
    
    func numberOfItems(in section: Int) -> Int {
        switch state {
        case .full:
            return contacts[section].items.count
        case .search:
            return found.count
        }
    }
    
    func title(for section: Int) -> String? {
        switch state {
        case .full:
            return contacts[section].title
        case .search:
            return  L10n.Contacts.searchResults
        }
    }
    
    subscript(indexPath: IndexPath) -> WalletViewModelProtocol? {
        switch state {
        case .full:
            return contacts[indexPath.section].items[indexPath.row]
        case .search:
            return found[indexPath.row]
        }
    }
}
