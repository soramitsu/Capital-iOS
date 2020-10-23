/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

struct ContactsCellStyle {
    let contactStyle: ContactCellStyleProtocol
    let sendOptionStyle: SendOptionCellStyleProtocol

    public init(contactStyle: ContactCellStyleProtocol,
                sendOptionStyle: SendOptionCellStyleProtocol) {
        self.contactStyle = contactStyle
        self.sendOptionStyle = sendOptionStyle
    }
}

protocol ContactsCellStylable {
    var style: ContactsCellStyle? { get set }
}
