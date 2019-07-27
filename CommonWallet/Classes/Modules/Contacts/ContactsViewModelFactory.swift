/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


public struct ContactConstants {
    static let contactCellIdentifier: String = "co.jp.capital.contact.cell.identifier"
    static let contactCellHeight: CGFloat = 56
    static let scanCellIdentifier: String = "co.jp.capital.contact.scan.cell.identifier"
    static let scanCellHeight: CGFloat = 56
}


protocol ContactsViewModelFactoryProtocol {
    
    func createContactViewModel(from contact: SearchData,
                                delegate: ContactViewModelDelegate?) -> ContactViewModelProtocol
    func createScanViewModel() -> SendOptionViewModelProtocol
    
}


final class ContactsViewModelFactory: ContactsViewModelFactoryProtocol {
    
    private let configuration: ContactsConfigurationProtocol
    private let avatarRadius: CGFloat
    private let commandFactory: WalletCommandFactoryProtocol

    init(configuration: ContactsConfigurationProtocol, avatarRadius: CGFloat,
         commandFactory: WalletCommandFactoryProtocol) {
        self.configuration = configuration
        self.avatarRadius = avatarRadius
        self.commandFactory = commandFactory
    }
    
    func createContactViewModel(from contact: SearchData,
                                delegate: ContactViewModelDelegate?) -> ContactViewModelProtocol {

        let image = UIImage.createAvatar(firstName: contact.firstName,
                                         lastName: contact.lastName,
                                         radius: avatarRadius,
                                         style: configuration.contactCellStyle.nameIcon)

        let viewModel = ContactViewModel(cellReuseIdentifier: ContactConstants.contactCellIdentifier,
                                         itemHeight: ContactConstants.contactCellHeight,
                                         contact: contact,
                                         image: image)
        
        viewModel.delegate = delegate
        viewModel.style = configuration.contactCellStyle
        
        return viewModel
    }
    
    func createScanViewModel() -> SendOptionViewModelProtocol {
        let scanCommand = commandFactory.prepareScanReceiverCommand()
        let viewModel = SendOptionViewModel(cellReuseIdentifier: ContactConstants.scanCellIdentifier,
                                            itemHeight: ContactConstants.scanCellHeight,
                                            command: scanCommand)

        viewModel.title = "Scan QR code"
        viewModel.icon = UIImage(named: "qr", in: Bundle(for: type(of: self)), compatibleWith: nil)
        viewModel.style = configuration.sendOptionStyle
        
        return viewModel
    }
    
}
