import XCTest
@testable import CommonWallet
import Cuckoo

class TransferServiceTests: NetworkBaseTests {
    func testTransferSuccess() {
        do {
            // given
            let networkResolver = MockWalletNetworkResolverProtocol()

            let urlTemplateGetExpectation = XCTestExpectation()
            let adapterExpectation = XCTestExpectation()

            stub(networkResolver) { stub in
                when(stub).urlTemplate(for: any(WalletRequestType.self)).then { _ in
                    urlTemplateGetExpectation.fulfill()

                    return Constants.transferUrlTemplate
                }

                when(stub).adapter(for: any(WalletRequestType.self)).then { _ in
                    adapterExpectation.fulfill()

                    return nil
                }
            }

            try TransferMock.register(mock: .success,
                                      networkResolver: networkResolver,
                                      requestType: .transfer,
                                      httpMethod: .post)

            let assetsCount = 4
            let accountSettings = try createRandomAccountSettings(for: assetsCount)
            let operationFactory = WalletServiceOperationFactory(accountSettings: accountSettings)
            let walletService = WalletService(networkResolver: networkResolver,
                                              operationFactory: operationFactory)

            let transferExpectation = XCTestExpectation()

            // when

            let info = try createRandomTransferInfo()
            _ = walletService.transfer(info: info, runCompletionIn: .main) { (optionalResult) in
                defer {
                    transferExpectation.fulfill()
                }

                guard let result = optionalResult else {
                    XCTFail("Unexpected nil result")
                    return
                }

                if case .error(let error) = result {
                    XCTFail("Unexpected error \(error)")
                }
            }

            // then

            wait(for: [urlTemplateGetExpectation, adapterExpectation, transferExpectation],
                 timeout: Constants.networkTimeout)
        } catch {
            XCTFail("\(error)")
        }
    }
}
