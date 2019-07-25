import XCTest
@testable import CommonWallet

class AccessoryViewFactoryTests: XCTestCase {

    func testCreation() {
        XCTAssertNoThrow(AccessoryViewFactory.createAccessoryView(from: WalletStyle(), target: nil, completionSelector: nil)) 
    }
}
