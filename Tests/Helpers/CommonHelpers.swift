/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

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
    let operationSettings = try createRandomOperationSettings()

    let networkFactory = MiddlewareOperationFactory(accountSettings: account,
                                                    operationSettings: operationSettings,
                                                    networkResolver: networkResolver)

    return CommonWalletBuilder.builder(with: account, networkOperationFactory: networkFactory)
}
