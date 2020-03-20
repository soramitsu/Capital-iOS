/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation


public protocol ReceiveAmountModuleBuilderProtocol: class {
    @discardableResult
    func with(accountShareFactory: AccountShareFactoryProtocol) -> Self

    @discardableResult
    func with(title: LocalizableResource<String>) -> Self

    @discardableResult
    func with(shouldIncludeDescription: Bool) -> Self
}
