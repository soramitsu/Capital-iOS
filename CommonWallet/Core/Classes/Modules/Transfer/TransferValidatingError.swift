/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public enum TransferValidatingError: Error {
    case unsufficientFunds(assetId: String, available: Decimal)
    case missingBalance(assetId: String)
    case zeroAmount
    case minViolation(value: Decimal)
    case maxViolation(value: Decimal)
}

extension TransferValidatingError: WalletErrorContentConvertible {
    public func toErrorContent(for locale: Locale?) -> WalletErrorContentProtocol {
        let message: String

        switch self {
        case .unsufficientFunds:
            message = L10n.Amount.Error.noFunds
        case .minViolation(let value):
            message = L10n.Amount.Error.operationMinLimit("\(value)")
        case .missingBalance:
            message = L10n.Amount.Error.balance
        default:
            message = L10n.Amount.Error.transfer
        }

        return WalletErrorContent(title: L10n.Common.error, message: message)
    }
}
