import Foundation
@testable import CommonWallet

func resolver(from context: CommonWalletContextProtocol) -> ResolverProtocol? {
    guard let resolver = context as? Resolver else {
        return nil
    }

    return resolver
}

func createDefaultBuilder(with assetCount: Int) throws -> CommonWalletBuilderProtocol {
    let networkResolver = MockNetworkResolver()
    let account = try createRandomAccountSettings(for: 4)

    return CommonWalletBuilder.builder(with: account,
                                       networkResolver: networkResolver)
}
