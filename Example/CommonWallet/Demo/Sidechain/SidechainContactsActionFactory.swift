/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import CommonWallet

final class SidechainOptionViewModel: SendOptionViewModelProtocol {
    let title: String
    let icon: UIImage?

    let command: WalletCommandProtocol?

    public init(command: WalletCommandProtocol, title: String, icon: UIImage? = nil) {
        self.command = command
        self.title = title
        self.icon = icon
    }
}

final class SidechainContactsActionFactory: ContactsActionFactoryWrapperProtocol {
    weak var commandFactory: WalletCommandFactoryProtocol?

    func createOptionListForAccountId(_ accountId: String, assetId: String) -> [SendOptionViewModelProtocol]? {
        let receiver = ReceiveInfo(accountId: accountId,
                                   assetId: assetId,
                                   amount: nil,
                                   details: nil)

        let payload = TransferPayload(receiveInfo: receiver,
                                      receiverName: "My Account")

        guard let sendCommand = commandFactory?.prepareTransfer(with: payload) else {
            return nil
        }

        sendCommand.presentationStyle = .push(hidesBottomBar: true)

        let sendAction = SidechainOptionViewModel(command: sendCommand,
                                                  title: "Send to my account",
                                                  icon: UIImage(named: "iconEth"))

        return [sendAction]
    }
}
