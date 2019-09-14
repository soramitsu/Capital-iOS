/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol WalletInputValidatorFactoryProtocol: class {
    func createTransferDescriptionValidator() -> WalletInputValidatorProtocol?
    func createWithdrawDescriptionValidator(optionId: String) -> WalletInputValidatorProtocol?
}

public extension WalletInputValidatorFactoryProtocol {
    func createTransferDescriptionValidator() -> WalletInputValidatorProtocol? {
        return nil
    }

    func createWithdrawDescriptionValidator(optionId: String) -> WalletInputValidatorProtocol? {
        return nil
    }
}
