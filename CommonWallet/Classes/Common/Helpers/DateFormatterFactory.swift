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
