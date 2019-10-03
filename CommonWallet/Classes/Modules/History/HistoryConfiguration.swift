/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraUI

protocol HistoryConfigurationProtocol {
    var viewStyle: HistoryViewStyleProtocol { get }
    var cellStyle: TransactionCellStyleProtocol { get }
    var headerStyle: TransactionHeaderStyleProtocol { get }
    var supportsFilter: Bool { get }
    var includesFeeInAmount: Bool { get }
    var emptyStateDataSource: EmptyStateDataSource? { get }
    var emptyStateDelegate: EmptyStateDelegate? { get }
}

struct HistoryConfiguration: HistoryConfigurationProtocol {
    var viewStyle: HistoryViewStyleProtocol
    var cellStyle: TransactionCellStyleProtocol
    var headerStyle: TransactionHeaderStyleProtocol
    var supportsFilter: Bool
    var includesFeeInAmount: Bool
    var emptyStateDataSource: EmptyStateDataSource?
    weak var emptyStateDelegate: EmptyStateDelegate?
}
