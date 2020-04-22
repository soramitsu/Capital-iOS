/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

protocol ContactsActionViewModelFactoryProtocol {
    func createViewModelsForAccountId(_ accountId: String, assetId: String) -> [SendOptionViewModelProtocol]
}

final class ContactsActionViewModelFactory: ContactsActionViewModelFactoryProtocol {
    let commandFactory: WalletCommandFactoryProtocol
    let shouldIncludeScan: Bool
    let withdrawOptions: [WalletWithdrawOption]

    init(commandFactory: WalletCommandFactoryProtocol,
         shouldIncludeScan: Bool,
         withdrawOptions: [WalletWithdrawOption]) {
        self.commandFactory = commandFactory
        self.shouldIncludeScan = shouldIncludeScan
        self.withdrawOptions = withdrawOptions
    }

    func createViewModelsForAccountId(_ accountId: String, assetId: String) -> [SendOptionViewModelProtocol] {
        var viewModels: [SendOptionViewModelProtocol] = []

        if shouldIncludeScan {
            viewModels.append(createScanViewModel())
        }

        let withdrawViewModels = withdrawOptions.map { createWithdrawViewModel(for: $0, assetId: assetId) }
        viewModels.append(contentsOf: withdrawViewModels)

        return viewModels
    }

    // MARK: Private

    private func createScanViewModel() -> SendOptionViewModelProtocol {
        let scanCommand = commandFactory.prepareScanReceiverCommand()
        let viewModel = SendOptionViewModel(cellReuseIdentifier: ContactConstants.optionCellIdentifier,
                                            itemHeight: ContactConstants.optionCellHeight,
                                            command: scanCommand)

        viewModel.title =  L10n.Contacts.scan
        viewModel.icon = UIImage(named: "iconQr", in: Bundle(for: type(of: self)), compatibleWith: nil)

        return viewModel
    }

    private func createWithdrawViewModel(for option: WalletWithdrawOption,
                                 assetId: String) -> SendOptionViewModelProtocol {
        let withdrawCommand = commandFactory.prepareWithdrawCommand(for: assetId,
                                                                    optionId: option.identifier)

        let viewModel = SendOptionViewModel(cellReuseIdentifier: ContactConstants.optionCellIdentifier,
                                            itemHeight: ContactConstants.optionCellHeight,
                                            command: withdrawCommand)

        viewModel.title = option.longTitle
        viewModel.icon = option.icon

        return viewModel
    }
}
