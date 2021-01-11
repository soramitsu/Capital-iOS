/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

protocol ContactsActionViewModelFactoryProtocol {
    func createOptionListForAccountId(_ accountId: String,
                                      assetId: String,
                                      locale: Locale?,
                                      commandFactory: WalletCommandFactoryProtocol)
        -> [SendOptionViewModelProtocol]
    func createBarActionForAccountId(_ accountId: String,
                                     assetId: String,
                                     commandFactory: WalletCommandFactoryProtocol)
        -> WalletBarActionViewModelProtocol?
}

final class ContactsActionViewModelFactory: ContactsActionViewModelFactoryProtocol {
    let scanPosition: WalletContactsScanPosition
    let withdrawOptions: [WalletWithdrawOption]

    init(scanPosition: WalletContactsScanPosition, withdrawOptions: [WalletWithdrawOption]) {
        self.scanPosition = scanPosition
        self.withdrawOptions = withdrawOptions
    }

    func createOptionListForAccountId(_ accountId: String,
                                      assetId: String,
                                      locale: Locale?,
                                      commandFactory: WalletCommandFactoryProtocol)
    -> [SendOptionViewModelProtocol] {
        var viewModels: [SendOptionViewModelProtocol] = []

        if scanPosition == .tableAction {
            viewModels.append(createScanViewModel(commandFactory))
        }

        let withdrawViewModels = withdrawOptions.map {
            createWithdrawViewModel(for: $0,
                                    assetId: assetId,
                                    commandFactory: commandFactory)
        }

        viewModels.append(contentsOf: withdrawViewModels)

        return viewModels
    }

    func createBarActionForAccountId(_ accountId: String,
                                     assetId: String,
                                     commandFactory: WalletCommandFactoryProtocol)
        -> WalletBarActionViewModelProtocol? {
        guard scanPosition == .barButton else {
            return nil
        }

        guard let icon = UIImage(named: "iconQr", in: Bundle(for: type(of: self)), compatibleWith: nil) else {
            return nil
        }

        let scanCommand = commandFactory.prepareScanReceiverCommand()
        return WalletBarActionViewModel(displayType: .icon(icon), command: scanCommand)
    }

    // MARK: Private

    private func createScanViewModel(_ commandFactory: WalletCommandFactoryProtocol)
    -> SendOptionViewModelProtocol {
        let scanCommand = commandFactory.prepareScanReceiverCommand()
        let viewModel = SendOptionViewModel(command: scanCommand)

        viewModel.title =  L10n.Contacts.scan
        viewModel.icon = UIImage(named: "iconQr", in: Bundle(for: type(of: self)), compatibleWith: nil)

        return viewModel
    }

    private func createWithdrawViewModel(for option: WalletWithdrawOption,
                                         assetId: String,
                                         commandFactory: WalletCommandFactoryProtocol)
    -> SendOptionViewModelProtocol {
        let withdrawCommand = commandFactory.prepareWithdrawCommand(for: assetId,
                                                                    optionId: option.identifier)

        let viewModel = SendOptionViewModel(command: withdrawCommand)

        viewModel.title = option.longTitle
        viewModel.icon = option.icon

        return viewModel
    }
}
