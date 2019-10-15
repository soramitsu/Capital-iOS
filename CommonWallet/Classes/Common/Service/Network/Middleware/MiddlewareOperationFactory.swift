/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication
import RobinHood

final class MiddlewareOperationFactory: MiddlewareOperationFactoryProtocol {
    let accountSettings: WalletAccountSettingsProtocol
    let networkResolver: WalletNetworkResolverProtocol

    private(set) lazy var decoder = JSONDecoder()
    private(set) lazy var encoder = JSONEncoder()

    init(accountSettings: WalletAccountSettingsProtocol, networkResolver: WalletNetworkResolverProtocol) {
        self.accountSettings = accountSettings
        self.networkResolver = networkResolver
    }
}
