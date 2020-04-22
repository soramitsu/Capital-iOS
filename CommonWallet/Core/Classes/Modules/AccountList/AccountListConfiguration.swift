/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit

protocol AccountListConfigurationProtocol: CellRegisterable {
    var viewStyle: AccountListViewStyleProtocol { get }
    var viewModelContext: AccountListViewModelContext { get }
    var registeredCellsMetadata: [String: Any] { get }
    var minimumContentHeight: CGFloat { get }
}

struct AccountListConfiguration: AccountListConfigurationProtocol {
    var viewStyle: AccountListViewStyleProtocol
    var registeredCellsMetadata: [String: Any]
    var viewModelContext: AccountListViewModelContext
    var minimumContentHeight: CGFloat
}
