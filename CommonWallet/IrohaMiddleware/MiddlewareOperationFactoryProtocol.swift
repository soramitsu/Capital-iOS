/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol MiddlewareOperationFactoryProtocol: WalletNetworkOperationFactoryProtocol {
    var accountSettings: WalletAccountSettingsProtocol { get }
    var operationSettings: MiddlewareOperationSettingsProtocol { get }
    var networkResolver: MiddlewareNetworkResolverProtocol { get }
    var encoder: JSONEncoder { get }
    var decoder: JSONDecoder { get }
}
