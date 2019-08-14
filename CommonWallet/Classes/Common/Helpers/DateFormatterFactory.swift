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
            .withToday(title: "Today")
            .withYesterday(title: "Yesterday")
            .withThisYear(dateFormatter: DateFormatter.sectionThisYear)
            .build(defaultFormat: "dd MMMM yyyy")
    }
}
