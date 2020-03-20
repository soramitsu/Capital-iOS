/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation


protocol ReceiveAmountConfigurationProtocol {
    var accountShareFactory: AccountShareFactoryProtocol { get }
    var title: LocalizableResource<String> { get }
    var shouldIncludeDescription: Bool { get }
}


struct ReceiveAmountConfiguration: ReceiveAmountConfigurationProtocol {
    var accountShareFactory: AccountShareFactoryProtocol
    var title: LocalizableResource<String>
    var shouldIncludeDescription: Bool
}
