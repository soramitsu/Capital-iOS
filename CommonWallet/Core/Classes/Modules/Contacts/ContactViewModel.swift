/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import Contacts


public protocol ContactViewModelDelegate: class {
    
    func didSelect(contact: ContactViewModelProtocol)

}


public protocol ContactViewModelProtocol: WalletViewModelProtocol {
    var firstName: String { get }
    var lastName: String { get }
    var accountId: String { get }
    var image: UIImage? { get }
    var name: String { get }
}


final class ContactViewModel: ContactViewModelProtocol {
    
    private(set) var cellReuseIdentifier: String
    private(set) var itemHeight: CGFloat
    
    weak var delegate: ContactViewModelDelegate?
    
    private(set) var firstName: String
    private(set) var lastName: String
    private(set) var accountId: String
    private(set) var image: UIImage?
    
    var name: String {
        return L10n.Common.fullName(firstName, lastName)
    }
    
    init(cellReuseIdentifier: String, itemHeight: CGFloat, contact: SearchData, image: UIImage?) {
        self.cellReuseIdentifier = cellReuseIdentifier
        self.itemHeight = itemHeight
        
        firstName = contact.firstName
        lastName = contact.lastName
        accountId = contact.accountId
        
        self.image = image
        
    }
}

extension ContactViewModel: WalletCommandProtocol {
    var command: WalletCommandProtocol? { return self }

    func execute() throws {
        delegate?.didSelect(contact: self)
    }
}
