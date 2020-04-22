/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

protocol ContactsViewModelFactoryProtocol {
    func createContactViewModel(from contact: SearchData, delegate: ContactViewModelDelegate?) -> ContactViewModelProtocol
}


final class ContactsViewModelFactory {
    let avatarRadius: CGFloat
    let commandFactory: WalletCommandFactoryProtocol
    let nameIconStyle: WalletNameIconStyleProtocol

    init(commandFactory: WalletCommandFactoryProtocol, avatarRadius: CGFloat, nameIconStyle: WalletNameIconStyleProtocol) {
        self.commandFactory = commandFactory
        self.avatarRadius = avatarRadius
        self.nameIconStyle = nameIconStyle
    }
}

extension ContactsViewModelFactory: ContactsViewModelFactoryProtocol {
    func createContactViewModel(from contact: SearchData,
                                delegate: ContactViewModelDelegate?) -> ContactViewModelProtocol {

        let fullName = L10n.Common.fullName(contact.firstName, contact.lastName)
        let image = UIImage.createAvatar(fullName: fullName,
                                         radius: avatarRadius,
                                         style: nameIconStyle)

        let viewModel = ContactViewModel(cellReuseIdentifier: ContactConstants.contactCellIdentifier,
                                         itemHeight: ContactConstants.contactCellHeight,
                                         contact: contact,
                                         image: image)

        viewModel.delegate = delegate

        return viewModel
    }
}
