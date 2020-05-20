/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public enum OperationDefinitionChangeEvent {
    case asset
    case balance
    case amount
    case metadata
}

public protocol OperationDefinitionChangeHandling {
    func updateContentForChange(event: OperationDefinitionChangeEvent) -> [OperationDefinitionType]
    func clearErrorForChange(event: OperationDefinitionChangeEvent) -> [OperationDefinitionType]
    func shouldUpdateAccessoryForChange(event: OperationDefinitionChangeEvent) -> Bool
}

struct OperationDefinitionChangeHandler: OperationDefinitionChangeHandling {
    func updateContentForChange(event: OperationDefinitionChangeEvent) -> [OperationDefinitionType] {
        switch event {
        case .asset:
            return [.asset, .amount, .fee]
        case .balance:
            return [.asset]
        case .amount:
            return [.fee]
        case .metadata:
            return [.fee]
        }
    }

    func clearErrorForChange(event: OperationDefinitionChangeEvent) -> [OperationDefinitionType] {
        switch event {
        case .asset:
            return [.asset, .amount, .fee]
        case .balance:
            return [.asset, .amount, .fee]
        case .amount:
            return [.amount, .fee]
        case .metadata:
            return [.amount, .fee]
        }
    }

    func shouldUpdateAccessoryForChange(event: OperationDefinitionChangeEvent) -> Bool {
        false
    }
}
