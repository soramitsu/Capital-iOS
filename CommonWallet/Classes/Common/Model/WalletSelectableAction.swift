/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraFoundation

public struct WalletSelectableAction<T> {
    let title: LocalizableResource<String>
    let action: (T) -> Void

    public init(title: LocalizableResource<String>, action: @escaping (T) -> Void) {
        self.title = title
        self.action = action
    }
}
