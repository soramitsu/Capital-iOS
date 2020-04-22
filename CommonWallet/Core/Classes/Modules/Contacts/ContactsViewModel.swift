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


enum ContactListSection: Int, CaseIterable {
    case actions = 0
    case contacts = 1
}


protocol ContactListViewModelProtocol {
    
    var actions: [WalletViewModelProtocol] { get }
    var contacts: [WalletViewModelProtocol] { get }
    var found: [WalletViewModelProtocol] { get }
    var state: ContactListState { get }
    var isEmpty: Bool { get }
    var shouldDisplayEmptyState: Bool { get }
    var sectionCount: Int { get }
    
    func itemsCount(for section: Int) -> Int
    func title(for section: Int) -> String?
    
    subscript(indexPath: IndexPath) -> WalletViewModelProtocol? { get }
    
}


struct ContactListViewModel: ContactListViewModelProtocol {
    
    var actions: [WalletViewModelProtocol]
    var contacts: [WalletViewModelProtocol]
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
    
    var sectionCount: Int {
        return ContactListSection.allCases.count
    }
    
    init() {
        actions = []
        contacts = []
        found = []
    }
    
    func itemsCount(for section: Int) -> Int {
        guard let section = ContactListSection(rawValue: section) else {
            return 0
        }
        switch section {
        case .actions:
            return actions.count
        case .contacts:
            switch state {
            case .full:  return contacts.count
            case .search: return found.count
            }
        }
    }
    
    func title(for section: Int) -> String? {
        guard let section = ContactListSection(rawValue: section) else {
            return nil
        }
        switch section {
        case .actions:
            return nil
        case .contacts:
            switch state {
            case .full:  return L10n.Contacts.title
            case .search: return  L10n.Contacts.searchResults
            }
        }
    }
    
    subscript(indexPath: IndexPath) -> WalletViewModelProtocol? {
        guard let section = ContactListSection(rawValue: indexPath.section) else {
            return nil
        }
        
        switch section {
        case .actions:
            return actions[indexPath.row]
        case .contacts:
            switch state {
            case .full:  return contacts[indexPath.row]
            case .search: return found[indexPath.row]
            }
        }
    }
    
}
