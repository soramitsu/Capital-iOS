/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public struct OperationDefinitionErrorMapping {
    public let type: OperationDefinitionType
    public let message: String
    public let command: WalletCommandProtocol?

    public init(type: OperationDefinitionType, message: String, command: WalletCommandProtocol? = nil) {
        self.type = type
        self.message = message
        self.command = command
    }
}

public protocol OperationDefinitionErrorHandling {
    func mapError(_ error: Error, locale: Locale) -> OperationDefinitionErrorMapping?
}
