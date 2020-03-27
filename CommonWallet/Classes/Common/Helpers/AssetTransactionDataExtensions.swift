/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

extension AssetTransactionData {
    var localizedPeerName: String {
        if peerFirstName != nil || peerLastName != nil {
            let firstName = peerFirstName ?? ""
            let lastName = peerLastName ?? ""

            return L10n.Common.fullName(firstName, lastName)
        } else {
            return peerName ?? ""
        }
    }
}
