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
    func with(fieldsInclusion: ReceiveFieldsInclusion) -> Self

    @discardableResult
    func with(settings: WalletTransactionSettingsProtocol) -> Self

    @discardableResult
    func with(style: ReceiveStyleProtocol) -> Self

    @discardableResult
    func with(viewFactory: ReceiveViewFactoryProtocol) -> Self
}
