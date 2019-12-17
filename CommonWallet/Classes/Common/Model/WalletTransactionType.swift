/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


public struct WalletTransactionType: Equatable {
    
    public let backendName: String
    public let displayName: String
    public let isIncome: Bool
    public let typeIcon: UIImage?
    
    public init(backendName: String, displayName: String, isIncome: Bool, typeIcon: UIImage?) {
        self.backendName = backendName
        self.displayName = displayName
        self.isIncome = isIncome
        self.typeIcon = typeIcon
    }
    
}

public extension WalletTransactionType {
    static var incoming: WalletTransactionType {
        return WalletTransactionType(backendName: "INCOMING",
                                     displayName: L10n.Common.incoming,
                                     isIncome: true,
                                     typeIcon: nil)
    }

    static var outgoing: WalletTransactionType {
        return WalletTransactionType(backendName: "OUTGOING",
                                     displayName: L10n.Common.outgoing,
                                     isIncome: false,
                                     typeIcon: nil)
    }
}

extension WalletTransactionType {
    static var required: [WalletTransactionType] {
        return [.outgoing, .incoming]
    }
}
