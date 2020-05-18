/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public enum OperationDefinitionType {
    case asset
    case amount
    case receiver
    case description
    case fee
}

extension OperationDefinitionType {
    static var requiredTypes: Set<OperationDefinitionType> = [.asset, .amount, .description]
}

struct OperationDefinition<Item> {
    let mainView: Item
    var titleView: MultilineTitleIconView?
    var errorView: MultilineTitleIconView?

    init(mainView: Item, titleView: MultilineTitleIconView? = nil, errorView: MultilineTitleIconView? = nil) {
        self.mainView = mainView
        self.titleView = titleView
        self.errorView = errorView
    }
}
