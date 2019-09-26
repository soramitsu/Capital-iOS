import XCTest
@testable import CommonWallet
import Cuckoo

class WalletEventCenterTests: XCTestCase {
    func testObserversNotifications() {
        // given

        let observer1 = MockWalletEventVisitorProtocol()
        let observer2 = MockWalletEventVisitorProtocol()

        let eventCenter = WalletEventCenter()

        // when

        let expectationObserver1 = XCTestExpectation()

        stub(observer1) { stub in
            stub.processAccountUpdate(event: any()).then { _ in
                expectationObserver1.fulfill()
            }
        }

        let expectationObserver2 = XCTestExpectation()

        stub(observer2) { stub in
            stub.processAccountUpdate(event: any()).then { _ in
                expectationObserver2.fulfill()
            }
        }

        eventCenter.add(observer: observer1, dispatchIn: nil)
        eventCenter.add(observer: observer2, dispatchIn: nil)

        eventCenter.notify(with: AccountUpdateEvent())

        // then

        wait(for: [expectationObserver1, expectationObserver2], timeout: Constants.networkTimeout)

        // when

        eventCenter.remove(observer: observer1)

        let completionExpectation = XCTestExpectation()

        stub(observer2) { stub in
            stub.processAccountUpdate(event: any()).then { _ in
                completionExpectation.fulfill()
            }
        }

        eventCenter.notify(with: AccountUpdateEvent())

        // then

        wait(for: [completionExpectation], timeout: Constants.networkTimeout)

        verify(observer1, times(1)).processAccountUpdate(event: any())
        verify(observer2, times(2)).processAccountUpdate(event: any())
    }
}
