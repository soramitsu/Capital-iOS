import XCTest
@testable import CommonWallet
import SoraFoundation

class CompondDateFormatterTests: XCTestCase {
    func testToday() {
        let baseDate = Date(timeIntervalSince1970: 1525478400)
        let today = LocalizableResource { _ in "Today" }

        let gmtTimeZone = TimeZone(secondsFromGMT: 0)!

        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = gmtTimeZone
        let dateFormatter = CompoundDateFormatterBuilder(baseDate: baseDate, calendar: calendar)
            .withToday(title: today)
            .build(defaultFormat: "dd.MM.yyyy")

        let expected = today.value(for: Locale.current)

        XCTAssertEqual(expected, dateFormatter.string(from: Date(timeIntervalSince1970: 1525498400)))
        XCTAssertEqual(expected, dateFormatter.string(from: Date(timeIntervalSince1970: 1525558400)))
        XCTAssertEqual(expected, dateFormatter.string(from: Date(timeIntervalSince1970: 1525564799)))

        XCTAssertNotEqual(expected, dateFormatter.string(from: Date(timeIntervalSince1970: 1525478399)))
        XCTAssertNotEqual(expected, dateFormatter.string(from: Date(timeIntervalSince1970: 1493942400)))
        XCTAssertNotEqual(expected, dateFormatter.string(from: Date(timeIntervalSince1970: 1557014400)))
        XCTAssertNotEqual(expected, dateFormatter.string(from: Date(timeIntervalSince1970: 1522886400)))
        XCTAssertNotEqual(expected, dateFormatter.string(from: Date(timeIntervalSince1970: 1528156800)))
    }

    func testYesterday() {
        let baseDate = Date(timeIntervalSince1970: 1525478400)
        let yesterday = LocalizableResource { _ in "Yesterday" }

        let gmtTimeZone = TimeZone(secondsFromGMT: 0)!

        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = gmtTimeZone
        let dateFormatter = CompoundDateFormatterBuilder(baseDate: baseDate, calendar: calendar)
            .withYesterday(title: yesterday)
            .build(defaultFormat: "dd.MM.yyyy")

        let expected = yesterday.value(for: Locale.current)

        XCTAssertEqual(expected, dateFormatter.string(from: Date(timeIntervalSince1970: 1525392000)))
        XCTAssertEqual(expected, dateFormatter.string(from: Date(timeIntervalSince1970: 1525471980)))
        XCTAssertEqual(expected, dateFormatter.string(from: Date(timeIntervalSince1970: 1525478340)))

        XCTAssertNotEqual(expected, dateFormatter.string(from: Date(timeIntervalSince1970: 1525482000)))
        XCTAssertNotEqual(expected, dateFormatter.string(from: Date(timeIntervalSince1970: 1493856000)))
        XCTAssertNotEqual(expected, dateFormatter.string(from: Date(timeIntervalSince1970: 1556928000)))
        XCTAssertNotEqual(expected, dateFormatter.string(from: Date(timeIntervalSince1970: 1522800000)))
        XCTAssertNotEqual(expected, dateFormatter.string(from: Date(timeIntervalSince1970: 1528070400)))
    }

    func testYesterdayWhenFirstMonthDay() {
        let baseDate = Date(timeIntervalSince1970: 1530403200)
        let yesterday = LocalizableResource { _ in "Yesterday" }

        let gmtTimeZone = TimeZone(secondsFromGMT: 0)!

        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = gmtTimeZone
        let dateFormatter = CompoundDateFormatterBuilder(baseDate: baseDate, calendar: calendar)
            .withYesterday(title: yesterday)
            .build(defaultFormat: "dd.MM.yyyy")

        let expected = yesterday.value(for: Locale.current)

        XCTAssertEqual(expected, dateFormatter.string(from: Date(timeIntervalSince1970: 1530316800)))
    }

    func testYesterdayWhenFirstYearDay() {
        let baseDate = Date(timeIntervalSince1970: 1514764800)
        let yesterday = LocalizableResource { _ in "Yesterday" }

        let gmtTimeZone = TimeZone(secondsFromGMT: 0)!

        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = gmtTimeZone
        let dateFormatter = CompoundDateFormatterBuilder(baseDate: baseDate, calendar: calendar)
            .withYesterday(title: yesterday)
            .build(defaultFormat: "dd.MM.yyyy")

        let expected = yesterday.value(for: Locale.current)

        XCTAssertEqual(expected, dateFormatter.string(from: Date(timeIntervalSince1970: 1514678400)))
    }

    func testThisYear() {
        let baseDate = Date(timeIntervalSince1970: 1525478400)

        let gmtTimeZone = TimeZone(identifier: "UTC")!

        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = gmtTimeZone

        let thisYearFormatter = DateFormatter()
        thisYearFormatter.dateFormat = "dd.MM.yyyy"
        thisYearFormatter.timeZone = gmtTimeZone

        let dateFormatter = CompoundDateFormatterBuilder(baseDate: baseDate, calendar: calendar)
            .withToday(title: LocalizableResource { _ in "Today" })
            .withYesterday(title: LocalizableResource { _ in "Yesterday" })
            .withThisYear(dateFormatter: thisYearFormatter.localizableResource())
            .build(defaultFormat: "dd MM yyyy")

        XCTAssertEqual("06.05.2018", dateFormatter.string(from: Date(timeIntervalSince1970: 1525564800)))
        XCTAssertEqual("05.04.2018", dateFormatter.string(from: Date(timeIntervalSince1970: 1522886400)))
        XCTAssertEqual("05.06.2018", dateFormatter.string(from: Date(timeIntervalSince1970: 1528156800)))
        XCTAssertEqual("01.01.2018", dateFormatter.string(from: Date(timeIntervalSince1970: 1514764800)))
        XCTAssertEqual("31.12.2018", dateFormatter.string(from: Date(timeIntervalSince1970: 1546214400)))

        XCTAssertNotEqual("06.05.2015", dateFormatter.string(from: Date(timeIntervalSince1970: 1430870400)))
        XCTAssertNotEqual("05.04.2016", dateFormatter.string(from: Date(timeIntervalSince1970: 1459814400)))
        XCTAssertNotEqual("05.06.2017", dateFormatter.string(from: Date(timeIntervalSince1970: 1496620800)))
        XCTAssertNotEqual("01.01.2019", dateFormatter.string(from: Date(timeIntervalSince1970: 1546300800)))
        XCTAssertNotEqual("31.12.2020", dateFormatter.string(from: Date(timeIntervalSince1970: 1609372800)))
    }

    func testDefaultBehavior() {
        let baseDate = Date(timeIntervalSince1970: 1525478400)

        let gmtTimeZone = TimeZone(identifier: "UTC")!

        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = gmtTimeZone

        let thisYearFormatter = DateFormatter()
        thisYearFormatter.dateFormat = "dd.MM.yyyy"
        thisYearFormatter.timeZone = gmtTimeZone

        let dateFormatter = CompoundDateFormatterBuilder(baseDate: baseDate, calendar: calendar)
            .withToday(title: LocalizableResource { _ in "Today" })
            .withYesterday(title: LocalizableResource { _ in "Yesterday" })
            .withThisYear(dateFormatter: thisYearFormatter.localizableResource())
            .build(defaultFormat: "dd MM yyyy")

        XCTAssertEqual("06 05 2015", dateFormatter.string(from: Date(timeIntervalSince1970: 1430870400)))
        XCTAssertEqual("05 04 2016", dateFormatter.string(from: Date(timeIntervalSince1970: 1459814400)))
        XCTAssertEqual("05 06 2017", dateFormatter.string(from: Date(timeIntervalSince1970: 1496620800)))
        XCTAssertEqual("01 01 2019", dateFormatter.string(from: Date(timeIntervalSince1970: 1546300800)))
        XCTAssertEqual("31 12 2020", dateFormatter.string(from: Date(timeIntervalSince1970: 1609372800)))

        XCTAssertNotEqual("06 05 2018", dateFormatter.string(from: Date(timeIntervalSince1970: 1525564800)))
        XCTAssertNotEqual("05 04 2018", dateFormatter.string(from: Date(timeIntervalSince1970: 1522886400)))
        XCTAssertNotEqual("05 06 2018", dateFormatter.string(from: Date(timeIntervalSince1970: 1528156800)))
        XCTAssertNotEqual("01 01 2018", dateFormatter.string(from: Date(timeIntervalSince1970: 1514764800)))
        XCTAssertNotEqual("31 12 2018", dateFormatter.string(from: Date(timeIntervalSince1970: 1546214400)))
    }
}
