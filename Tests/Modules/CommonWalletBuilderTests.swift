import XCTest
@testable import CommonWallet
import Cuckoo

class CommonWalletBuilderTests: XCTestCase {
    func testDefaultCommonWalletBuilder() {
        do {
            let commonWalletBuilder = try createDefaultBuilder(with: 4)
            _ = try commonWalletBuilder.build()
        } catch {
            XCTFail("\(error)")
        }
    }

    func testNumberFormatterSetup() {
        do {
            let numberFormatter = NumberFormatter()
            let navigationController = try createDefaultBuilder(with: 4)
                .with(amountFormatter: numberFormatter)
                .build()

            guard let resolver = resolver(from: navigationController) else {
                XCTFail()
                return
            }

            XCTAssertTrue(resolver.amountFormatter === numberFormatter)

        } catch {
            XCTFail("\(error)")
        }
    }

    private func createDefaultBuilder(with assetCount: Int) throws -> CommonWalletBuilderProtocol {
        let networkResolver = MockWalletNetworkResolverProtocol()

        stub(networkResolver) { stub in
            when(stub).urlTemplate(for: any(WalletRequestType.self)).then { _ in
                return Constants.balanceUrlTemplate
            }

            when(stub).adapter(for: any(WalletRequestType.self)).then { _ in
                return nil
            }
        }

        let account = try createRandomAccountSettings(for: 4)

        return CommonWalletBuilder.builder(with: account,
                                           networkResolver: networkResolver)
    }

    private func resolver(from rootController: UIViewController) -> ResolverProtocol? {
        guard let navigationController = rootController as? UINavigationController else {
            return nil
        }

        guard let dashboard = navigationController.viewControllers.first as? DashboardViewController else {
            return nil
        }

        guard let accountListController = dashboard.content as? AccountListViewController else {
            return nil
        }

        guard let presenter = accountListController.presenter as? AccountListPresenter else {
            return nil
        }

        guard let coordinator = presenter.coordinator as? AccountListCoordinator else {
            return nil
        }

        return coordinator.resolver
    }
}
