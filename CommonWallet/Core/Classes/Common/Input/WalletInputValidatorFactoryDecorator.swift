/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

final class WalletInputValidatorFactoryDecorator {
    var underlyingFactory: WalletInputValidatorFactoryProtocol?

    let descriptionMaxLength: UInt8

    init(descriptionMaxLength: UInt8) {
        self.descriptionMaxLength = descriptionMaxLength
    }

    func createDefaultValidator() -> WalletInputValidatorProtocol {
        let hint = L10n.Common.Input.validatorMaxHint("\(descriptionMaxLength)")
        return WalletDefaultInputValidator(hint: hint, maxLength: descriptionMaxLength)
    }
}

extension WalletInputValidatorFactoryDecorator: WalletInputValidatorFactoryProtocol {
    func createTransferDescriptionValidator() -> WalletInputValidatorProtocol? {
        guard let validator = underlyingFactory?.createTransferDescriptionValidator() else {
            return createDefaultValidator()
        }

        return validator
    }

    func createWithdrawDescriptionValidator(optionId: String) -> WalletInputValidatorProtocol? {
        guard let validator = underlyingFactory?.createWithdrawDescriptionValidator(optionId: optionId) else {
                return createDefaultValidator()
        }

        return validator
    }

    func createReceiveDescriptionValidator() -> WalletInputValidatorProtocol? {
        guard let validator = underlyingFactory?.createReceiveDescriptionValidator() else {
                return createDefaultValidator()
        }

        return validator
    }
}
