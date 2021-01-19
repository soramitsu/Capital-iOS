/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import CommonWallet

final class SidechainTransferViewModelFactory: TransferViewModelFactoryOverriding {
    let iconStyle: WalletNameIconStyleProtocol

    init(iconStyle: WalletNameIconStyleProtocol) {
        self.iconStyle = iconStyle
    }

    func createAccessoryViewModel(_ inputState: TransferInputState,
                                  payload: TransferPayload?,
                                  locale: Locale) throws -> AccessoryViewModelProtocol? {
        if let payload = payload {
            let icon = UIImage.createAvatar(fullName: payload.receiverName,
                                            style: iconStyle)

            return AccessoryViewModel(title: payload.receiverName,
                                      action: L10n.Common.next,
                                      icon: icon,
                                      shouldAllowAction: false)
        } else {
            return AccessoryViewModel(title: "", action: L10n.Common.next, shouldAllowAction: true)
        }
    }
}
