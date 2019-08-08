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
}
