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
    var titleView: BaseOperationDefinitionHeaderView?
    var errorView: BaseOperationDefinitionErrorView?

    init(mainView: Item,
         titleView: BaseOperationDefinitionHeaderView? = nil,
         errorView: BaseOperationDefinitionErrorView? = nil) {
        self.mainView = mainView
        self.titleView = titleView
        self.errorView = errorView
    }
}
