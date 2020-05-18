/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public struct OperationDefinitionErrorMapping {
    public let type: OperationDefinitionType
    public let message: String

    public init(type: OperationDefinitionType, message: String) {
        self.type = type
        self.message = message
    }
}

public protocol OperationDefinitionErrorHandling {
    func mapError(_ error: Error, locale: Locale) -> OperationDefinitionErrorMapping?
}
