/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import CommonWallet

final class DemoInputValidatorFactory: WalletInputValidatorFactoryProtocol {
    func createWithdrawDescriptionValidator(optionId: String) -> WalletInputValidatorProtocol? {
        return WalletDefaultInputValidator.ethereumAddress
    }

    func createReceiveDescriptionValidator() -> WalletInputValidatorProtocol? {
        let maxLength: UInt8 = 25
        let hint = L10n.Common.Input.validatorMaxHint(String(maxLength))
        return WalletDefaultInputValidator(hint: hint,
                                           maxLength: maxLength,
                                           validCharset: .alphanumerics,
                                           predicate: nil,
                                           lengthMetric: .character)
    }
}
