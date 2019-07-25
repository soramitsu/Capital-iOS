import XCTest

class NetworkBaseTests: XCTestCase {

    override func setUp() {
        NetworkMockManager.shared.enable()
    }

    override func tearDown() {
        NetworkMockManager.shared.disable()
    }
}
