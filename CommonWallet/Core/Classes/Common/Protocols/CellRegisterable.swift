/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


protocol CellRegisterable {
    var registeredCellsMetadata: [String: Any] { get }
}
