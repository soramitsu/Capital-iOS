/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol TransferValidating {
    func validate(info: TransferInfo, balances: [BalanceData], metadata: TransferMetaData) throws
        -> TransferInfo
}

struct TransferValidator: TransferValidating {

    let transactionSettings: WalletTransactionSettingsProtocol

    func validate(info: TransferInfo, balances: [BalanceData], metadata: TransferMetaData) throws
        -> TransferInfo {
        guard info.amount.decimalValue > 0.0 else {
            throw TransferValidatingError.zeroAmount
        }

        let limit = transactionSettings
            .limitForAssetId(info.asset, senderId: info.source, receiverId: info.destination)

        if info.amount.decimalValue < limit.minimum {
            throw TransferValidatingError
                .minViolation(value: limit.minimum)
        }

        if info.amount.decimalValue > limit.maximum {
            throw TransferValidatingError
                .maxViolation(value: limit.maximum)
        }

        let mapping: [String: Decimal] = info.fees
            .reduce(into: [info.asset: info.amount.decimalValue]) { (result, fee) in
                let newValue = (result[fee.feeDescription.assetId] ?? 0) + fee.value.decimalValue
                result[fee.feeDescription.assetId] = newValue
        }

        for (assetId, value) in mapping {
            guard let balance = balances.first(where: {$0.identifier == assetId }) else {
                throw TransferValidatingError.missingBalance(assetId: assetId)
            }

            if value > balance.balance.decimalValue {
                throw TransferValidatingError.unsufficientFunds(assetId: assetId,
                                                                available: balance.balance.decimalValue)
            }
        }

        return info
    }
}
