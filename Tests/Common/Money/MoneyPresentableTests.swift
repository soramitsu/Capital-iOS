import XCTest
@testable import CommonWallet


final class MoneyPresenter: MoneyPresentable {
    
    var amount: String = ""
    
}


class MoneyPresentableTests: XCTestCase {
    
    private let separator = Locale.current.decimalSeparator!
    private let grouping = Locale.current.groupingSeparator!
    private var presenter: MoneyPresenter!
    
    override func setUp() {
        presenter = MoneyPresenter()
    }
    
    override func tearDown() {
        presenter = nil
    }
    
    
    func testAddSingleDigit() {
        // act
        let newAmount = presenter.add("1")
        
        // assert
        XCTAssert(newAmount == "1")
    }
    
    func testPreventsAddingNotANumber() {
        // act
        let newAmount = presenter.add("a")
        
        // assert
        XCTAssert(newAmount.isEmpty)
    }
    
    func testAddSeparator() {
        // arrange
        presenter.amount = "12"
        
        // act
        let newAmount = presenter.add(separator)
        
        // assert
        XCTAssert(newAmount == "12\(separator)")
    }
    
    func testAddsFirstFractional() {
        // arrange
        presenter.amount = "12\(separator)"
        
        // act
        let newAmount = presenter.add("3")
        
        // assert
        XCTAssert(newAmount == "12\(separator)3")
    }
    
    func testAddsSecondFractional() {
        // arrange
        presenter.amount = "12\(separator)3"
        
        // act
        let newAmount = presenter.add("4")
        
        // assert
        XCTAssert(newAmount == "12\(separator)34")
    }
    
    func testPreventsAddingMoreThanTwoFractionals() {
        // arrange
        presenter.amount = "12\(separator)34"
        
        // act
        let newAmount = presenter.add("5")
        
        // assert
        XCTAssert(newAmount == "12\(separator)34")
    }
    
    func testAddsSeparatorToEmptyAmount() {
        // arrange
        presenter = MoneyPresenter()
        
        // act
        let newAmount = presenter.add(separator)
        
        // assert
        XCTAssert(newAmount == "0\(separator)")
    }
    
    func testPreventsAddingSecondSeparator() {
        // arrange
        presenter.amount = "1\(separator)"
        
        // act
        let newAmount = presenter.add(separator)
        
        // assert
        XCTAssert(newAmount == "1\(separator)")
    }
    
    func testPreventsAddingSecondSeparatorAfterDigit() {
        // arrange
        presenter.amount = "1\(separator)2"
        
        // act
        let newAmount = presenter.add(separator)
        
        // assert
        XCTAssert(newAmount == "1\(separator)2")
    }
    
    func testSetNewAmount() {
        // act
        let newAmount = presenter.set("123")
        
        // assert
        XCTAssert(newAmount == "123")
    }
    
    func testSetTruncatedAmount() {
        // arrange
        presenter.amount = "123"
        
        // act
        let newAmount = presenter.set("12")
        
        // assert
        XCTAssert(newAmount == "12")
    }
    
    func testPreventsSetNotANumber() {
        // act
        let newAmount = presenter.set("12aa")
        
        // assert
        XCTAssert(newAmount.isEmpty)
    }
    
    
    func testPreventsSetMoreThanTwoFractionals() {
        // act
        let newAmount = presenter.set("12\(separator)345")
        
        // assert
        XCTAssert(newAmount.isEmpty)
    }
    
    func testAllowSetEmptyAmount() {
        // act
        let newAmount = presenter.set("")
        
        // assert
        XCTAssertEqual(newAmount, "")
    }

    func testAllowSetWithTrallingSeparator() {
        // act
        let amount = presenter.set("123.")

        // asset
        XCTAssertEqual(amount, "123\(separator)")
    }

    func testAllowSetWithLeadingSeparator() {
        // act
        let amount = presenter.set(".12")

        // asset
        XCTAssertEqual(amount, "0\(separator)12")
    }

    func testFormattedAmount() {
        // arrange
        presenter.amount = "1234"
        
        // act
        let formatted = presenter.formattedAmount
        
        // assert
        XCTAssert(formatted == "1\(grouping)234")
    }
    
    func testFormattedAmountWithSeparator() {
        // arrange
        presenter.amount = "1234"
        
        // act
        presenter.amount = presenter.add(separator)
        let formatted = presenter.formattedAmount
        
        // assert
        XCTAssert(formatted == "1\(grouping)234\(separator)")
    }
    
    func testFormattedAmountWithZeroInFraction() {
        // arrange
        presenter.amount = "1234."
        
        // act
        presenter.amount = presenter.add("0")
        let formatted = presenter.formattedAmount
        
        // assert
        XCTAssert(formatted == "1\(grouping)234\(separator)0")
    }
    
    func testFormattedAmountWithTwoZerosInFraction() {
        // arrange
        presenter.amount = "1234.0"
        
        // act
        presenter.amount = presenter.add("0")
        let formatted = presenter.formattedAmount
        
        // assert
        XCTAssert(formatted == "1\(grouping)234\(separator)00")
    }

    func testFormattedAmountWithSuffixZero() {
        // arrange
        presenter.amount = "1234.1"

        // act
        presenter.amount = presenter.add("0")

        // assert
        XCTAssertEqual(presenter.formattedAmount, "1\(grouping)234\(separator)10")
    }
}
