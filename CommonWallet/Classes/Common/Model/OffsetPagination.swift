/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication


public struct OffsetPagination: Codable, Equatable {
    var offset: Int
    var count: Int
}
