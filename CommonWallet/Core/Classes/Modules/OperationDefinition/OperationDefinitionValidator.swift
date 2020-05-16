/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol OperationDefinitionValidating {
    func validate(info: TransferInfo, balances: [BalanceData]) throws
}

public enum OperationDefinitionValidatingError: Error {
    case unsufficientFunds(assetId: String)
    case missingBalance(assetId: String)
    case zeroAmount
    case minViolation(value: Decimal)
    case maxViolation(value: Decimal)
}

struct OperationDefinitionValidator: OperationDefinitionValidating {

    let transactionSettings: WalletTransactionSettingsProtocol

    func validate(info: TransferInfo, balances: [BalanceData]) throws {
        guard info.amount.decimalValue > 0.0 else {
            throw OperationDefinitionValidatingError.zeroAmount
        }

        let limit = transactionSettings
            .limitForAssetId(info.asset, senderId: info.source, receiverId: info.destination)

        if info.amount.decimalValue < limit.minimum {
            throw OperationDefinitionValidatingError
                .minViolation(value: limit.minimum)
        }

        if info.amount.decimalValue > limit.maximum {
            throw OperationDefinitionValidatingError
                .maxViolation(value: limit.maximum)
        }

        let mapping: [String: Decimal] = info.fees
            .reduce(into: [info.asset: info.amount.decimalValue]) { (result, fee) in
                let newValue = (result[fee.feeDescription.assetId] ?? 0) + fee.value.decimalValue
                result[fee.feeDescription.assetId] = newValue
        }

        for (assetId, value) in mapping {
            guard let balance = balances.first(where: {$0.identifier == assetId }) else {
                throw OperationDefinitionValidatingError.missingBalance(assetId: assetId)
            }

            if value > balance.balance.decimalValue {
                throw OperationDefinitionValidatingError.unsufficientFunds(assetId: assetId)
            }
        }
    }
}
