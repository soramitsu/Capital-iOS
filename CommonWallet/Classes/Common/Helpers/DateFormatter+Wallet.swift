import Foundation

extension DateFormatter {
    static var historyDateFormatter: DateFormatter {
        let dateFormatterBuilder = CompoundDateFormatterBuilder()
        return dateFormatterBuilder
            .withToday(title: "Today")
            .withYesterday(title: "Yesterday")
            .withThisYear(dateFormatter: DateFormatter.sectionThisYear)
            .build(defaultFormat: "dd MMMM YYYY")
    }

    static var sectionThisYear: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        return dateFormatter
    }

    static var statusDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM YYYY, HH:mm:ss"
        return dateFormatter
    }
}
