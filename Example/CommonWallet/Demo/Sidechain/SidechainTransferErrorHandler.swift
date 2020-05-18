/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import CommonWallet

struct SidechainTransferErrorHandler: OperationDefinitionErrorHandling {
    func mapError(_ error: Error, locale: Locale) -> OperationDefinitionErrorMapping? {
        if let validationError = error as? TransferValidatingError {
            switch validationError {
            case .unsufficientFunds:
                return OperationDefinitionErrorMapping(type: .amount,
                                                       message: "Unsufficient funds")
            default:
                return nil
            }
        } else {
            return nil
        }
    }
}
