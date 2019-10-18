/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication


public struct OffsetPagination: Codable, Equatable {
    public var offset: Int
    public var count: Int

    init(offset: Int, count: Int) {
        self.offset = offset
        self.count = count
    }
}
