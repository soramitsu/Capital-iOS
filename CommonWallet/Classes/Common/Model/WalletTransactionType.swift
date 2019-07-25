/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


public struct WalletTransactionType: Equatable {
    
    var backendName: String
    var displayName: String
    var typeIcon: UIImage?
    
    public init(backendName: String, displayName: String, typeIcon: UIImage?) {
        self.backendName = backendName
        self.displayName = displayName
        self.typeIcon = typeIcon
    }
    
}
