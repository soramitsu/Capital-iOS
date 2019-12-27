import XCTest
@testable import CommonWallet

class LanguageSwitchCommandTests: XCTestCase {
    func testLanguageSwitch() {
        do {
            // given

            let context = try createDefaultBuilder(with: 4).with(language: WalletLanguage.english).build()

            guard let resolver = resolver(from: context) else {
                XCTFail()
                return
            }

            let languageChangeExpectation = XCTestExpectation()

            resolver.localizationManager?.addObserver(with: self) { (_, _) in
                languageChangeExpectation.fulfill()
            }

            // when

            let command = context.prepareLanguageSwitchCommand(with: WalletLanguage.khmer)
            try command.execute()

            // then

            wait(for: [languageChangeExpectation], timeout: Constants.networkTimeout)

            XCTAssertEqual(resolver.localizationManager?.selectedLocalization,
                           WalletLanguage.khmer.rawValue)
            XCTAssertEqual(L10n.sharedLanguage, WalletLanguage.khmer)

        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }
}
