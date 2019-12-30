/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation

public protocol DateFormatterFactoryProtocol {
    static func createDateFormatter() -> DateFormatter
}

struct TransactionListSectionFormatterFactory: DateFormatterFactoryProtocol {
    static func createDateFormatter() -> DateFormatter {
        let dateFormatterBuilder = CompoundDateFormatterBuilder()

        let today = LocalizableResource { _ in L10n.Common.today }
        let yesterday = LocalizableResource { _ in L10n.Common.yesterday }
        let dateFormatter = DateFormatter.sectionThisYear.localizableResource()

        return dateFormatterBuilder
            .withToday(title: today)
            .withYesterday(title: yesterday)
            .withThisYear(dateFormatter: dateFormatter)
            .build(defaultFormat: "dd MMMM yyyy")
    }
}
