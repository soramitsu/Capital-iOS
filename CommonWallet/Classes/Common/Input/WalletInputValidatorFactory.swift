import Foundation

public protocol WalletInputValidatorFactoryProtocol: class {
    func createTransferDescriptionValidator() -> WalletInputValidatorProtocol?
    func createWithdrawDescriptionValidator(optionId: String) -> WalletInputValidatorProtocol?
}

extension WalletInputValidatorFactoryProtocol {
    func createTransferDescriptionValidator() -> WalletInputValidatorProtocol? {
        return nil
    }

    func createWithdrawDescriptionValidator(optionId: String) -> WalletInputValidatorProtocol? {
        return nil
    }
}
