/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood

public final class MiddlewareOperationFactory: MiddlewareOperationFactoryProtocol {
    public let accountSettings: WalletAccountSettingsProtocol
    public let operationSettings: MiddlewareOperationSettingsProtocol
    public let networkResolver: MiddlewareNetworkResolverProtocol

    public private(set) lazy var decoder = JSONDecoder()
    public private(set) lazy var encoder = JSONEncoder()

    public init(accountSettings: WalletAccountSettingsProtocol,
                operationSettings: MiddlewareOperationSettingsProtocol,
                networkResolver: MiddlewareNetworkResolverProtocol) {
        self.accountSettings = accountSettings
        self.operationSettings = operationSettings
        self.networkResolver = networkResolver
    }
}
