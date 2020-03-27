/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood

public protocol WalletNetworkResolverProtocol {
    func urlTemplate(for type: WalletRequestType) -> String
    func adapter(for type: WalletRequestType) -> NetworkRequestModifierProtocol?
    func errorFactory(for type: WalletRequestType) -> WalletNetworkErrorFactoryProtocol?
}
