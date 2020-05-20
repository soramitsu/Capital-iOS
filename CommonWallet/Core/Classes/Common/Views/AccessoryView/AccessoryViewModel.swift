/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol AccessoryViewModelProtocol {
    var title: String { get }
    var icon: UIImage? { get }
    var action: String { get }
    var numberOfLines: Int { get }
}

public struct AccessoryViewModel: AccessoryViewModelProtocol {
    public var title: String
    public var icon: UIImage?
    public var action: String
    public var numberOfLines: Int

    public init(title: String, action: String, icon: UIImage? = nil, numberOfLines: Int = 1) {
        self.title = title
        self.icon = icon
        self.action = action
        self.numberOfLines = numberOfLines
    }
}
