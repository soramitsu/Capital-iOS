/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

struct ContactsCellStyle {
    let contactStyle: ContactCellStyleProtocol
    let sendOptionStyle: SendOptionCellStyleProtocol
    let displaysSeparatorForLastCell: Bool

    public init(contactStyle: ContactCellStyleProtocol,
                sendOptionStyle: SendOptionCellStyleProtocol,
                displaysSeparatorForLastCell: Bool = false) {
        self.contactStyle = contactStyle
        self.sendOptionStyle = sendOptionStyle
        self.displaysSeparatorForLastCell = displaysSeparatorForLastCell
    }
}

protocol ContactsCellStylable {
    var style: ContactsCellStyle? { get set }
}
