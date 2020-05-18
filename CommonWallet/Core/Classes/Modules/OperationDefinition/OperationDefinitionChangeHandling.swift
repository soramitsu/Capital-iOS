/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol OperationDefinitionChangeHandling {
    func updateContentAfterChangeIn(_ type: OperationDefinitionType) -> [OperationDefinitionType]
    func clearErrorAfterChangeIn(_ type: OperationDefinitionType) -> [OperationDefinitionType]
}

struct OperationDefinitionChangeHandler: OperationDefinitionChangeHandling {
    func updateContentAfterChangeIn(_ type: OperationDefinitionType) -> [OperationDefinitionType] {
        [type]
    }

    func clearErrorAfterChangeIn(_ type: OperationDefinitionType) -> [OperationDefinitionType] {
        [type]
    }
}
