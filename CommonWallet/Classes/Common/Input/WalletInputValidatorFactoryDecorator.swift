import Foundation
import IrohaCommunication

final class WalletInputValidatorFactoryDecorator {
    var underlyingFactory: WalletInputValidatorFactoryProtocol?

    let descriptionMaxLength: UInt8

    init(descriptionMaxLength: UInt8) {
        self.descriptionMaxLength = descriptionMaxLength
    }

    func createDefaultValidator() -> WalletInputValidatorProtocol {
        let hint = "Maximum \(descriptionMaxLength) symbols"
        return LimitDescriptionValidator(maxLength: descriptionMaxLength, hint: hint)
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
}
