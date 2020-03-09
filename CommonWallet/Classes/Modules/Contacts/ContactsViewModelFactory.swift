/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication

public struct ContactConstants {
    static let contactCellIdentifier: String = "co.jp.capital.contact.cell.identifier"
    static let contactCellHeight: CGFloat = 56
    static let optionCellIdentifier: String = "co.jp.capital.contact.option.cell.identifier"
    static let optionCellHeight: CGFloat = 56
}


protocol ContactsViewModelFactoryProtocol {
    
    func createContactViewModel(from contact: SearchData,
                                delegate: ContactViewModelDelegate?) -> ContactViewModelProtocol
    func createScanViewModel(for assetId: IRAssetId) -> SendOptionViewModelProtocol
    func createWithdrawViewModel(for option: WalletWithdrawOption,
                                 assetId: IRAssetId) -> SendOptionViewModelProtocol
    
}


final class ContactsViewModelFactory {
    
    let configuration: ContactsConfigurationProtocol
    let avatarRadius: CGFloat
    let commandFactory: WalletCommandFactoryProtocol

    init(configuration: ContactsConfigurationProtocol,
         avatarRadius: CGFloat,
         commandFactory: WalletCommandFactoryProtocol) {
        self.configuration = configuration
        self.avatarRadius = avatarRadius
        self.commandFactory = commandFactory
    }
}

extension ContactsViewModelFactory: ContactsViewModelFactoryProtocol {
    func createContactViewModel(from contact: SearchData,
                                delegate: ContactViewModelDelegate?) -> ContactViewModelProtocol {

        let fullName = L10n.Common.fullName(contact.firstName, contact.lastName)
        let image = UIImage.createAvatar(fullName: fullName,
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

    func createScanViewModel(for assetId: IRAssetId) -> SendOptionViewModelProtocol {
        let scanCommand = commandFactory.prepareScanReceiverCommand()
        let viewModel = SendOptionViewModel(cellReuseIdentifier: ContactConstants.optionCellIdentifier,
                                            itemHeight: ContactConstants.optionCellHeight,
                                            command: scanCommand)

        viewModel.title =  L10n.Contacts.scan
        viewModel.icon = UIImage(named: "iconQr", in: Bundle(for: type(of: self)), compatibleWith: nil)
        viewModel.style = configuration.sendOptionStyle

        return viewModel
    }

    func createWithdrawViewModel(for option: WalletWithdrawOption,
                                 assetId: IRAssetId) -> SendOptionViewModelProtocol {
        let withdrawCommand = commandFactory.prepareWithdrawCommand(for: assetId,
                                                                    optionId: option.identifier)

        let viewModel = SendOptionViewModel(cellReuseIdentifier: ContactConstants.optionCellIdentifier,
                                            itemHeight: ContactConstants.optionCellHeight,
                                            command: withdrawCommand)

        viewModel.title = option.longTitle
        viewModel.icon = option.icon
        viewModel.style = configuration.sendOptionStyle

        return viewModel
    }
}
