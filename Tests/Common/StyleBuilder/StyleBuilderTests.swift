import XCTest
@testable import CommonWallet

class StyleBuilderTests: XCTestCase {

    func testNavigationBarStyleChanges() {
        var defaultStyleBuilder = WalletStyleBuilder()

        var navigationBarStyle = WalletNavigationBarStyle(barColor: .white,
                                                          shadowColor: .black,
                                                          itemTintColor: .red,
                                                          titleColor: .green,
                                                          titleFont: .walletHeader4)
        navigationBarStyle.titleColor = .black

        defaultStyleBuilder = defaultStyleBuilder.with(navigationBarStyle: navigationBarStyle)
        let style = defaultStyleBuilder.build()

        guard let expectedBarStyle = style.navigationBarStyle as? WalletNavigationBarStyle else {
            XCTFail()
            return
        }

        XCTAssertTrue(navigationBarStyle == expectedBarStyle)
    }
}
