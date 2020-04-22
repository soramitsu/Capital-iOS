/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public struct SearchData: Codable, Equatable {
    public var accountId: String
    public var firstName: String
    public var lastName: String

    public init(accountId: String, firstName: String, lastName: String) {
        self.accountId = accountId
        self.firstName = firstName
        self.lastName = lastName
    }
}
