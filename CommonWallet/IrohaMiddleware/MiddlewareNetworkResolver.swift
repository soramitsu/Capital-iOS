/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood

public protocol MiddlewareNetworkResolverProtocol {
    func urlTemplate(for type: MiddlewareRequestType) -> String
    func adapter(for type: MiddlewareRequestType) -> NetworkRequestModifierProtocol?
    func errorFactory(for type: MiddlewareRequestType) -> MiddlewareNetworkErrorFactoryProtocol?
}
