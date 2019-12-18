/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol DateFormatterFactoryProtocol {
    static func createDateFormatter() -> DateFormatter
}

struct TransactionListSectionFormatterFactory: DateFormatterFactoryProtocol {
    static func createDateFormatter() -> DateFormatter {
        let dateFormatterBuilder = CompoundDateFormatterBuilder()
        return dateFormatterBuilder
            .withToday(title: L10n.Common.today)
            .withYesterday(title: L10n.Common.yesterday)
            .withThisYear(dateFormatter: DateFormatter.sectionThisYear)
            .build(defaultFormat: "dd MMMM yyyy")
    }
}
