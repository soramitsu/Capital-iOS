/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import CommonWallet

final class SidechainConfirmViewModelFactory: TransferConfirmationViewModelFactoryOverriding {
    let iconStyle: WalletNameIconStyleProtocol

    init(iconStyle: WalletNameIconStyleProtocol) {
        self.iconStyle = iconStyle
    }

    func createAccessoryViewModelFromPayload(_ payload: ConfirmationPayload,
                                             locale: Locale) -> AccessoryViewModelProtocol? {
        let icon = UIImage.createAvatar(fullName: payload.receiverName,
                                        style: iconStyle)

        return AccessoryViewModel(title: payload.receiverName,
                                  action: L10n.Common.next,
                                  icon: icon,
                                  shouldAllowAction: true)
    }
}
