/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication
import RobinHood

final class WalletNetworkOperationFactory: IrohaOperationFactoryProtocol {
    let accountSettings: WalletAccountSettingsProtocol

    private(set) lazy var decoder = JSONDecoder()
    private(set) lazy var encoder = JSONEncoder()

    init(accountSettings: WalletAccountSettingsProtocol) {
        self.accountSettings = accountSettings
    }
}
