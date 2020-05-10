/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol AssetSelectionViewModelProtocol {
    var title: String { get }
    var subtitle: String { get }
    var details: String { get }
    var icon: UIImage? { get }
    var isSelecting: Bool { get }
    var canSelect: Bool { get }
}

public struct AssetSelectionViewModel: AssetSelectionViewModelProtocol {
    public let title: String
    public let subtitle: String
    public let details: String
    public let icon: UIImage?
    public let isSelecting: Bool
    public let canSelect: Bool

    init(title: String,
         subtitle: String,
         details: String,
         icon: UIImage?,
         isSelecting: Bool,
         canSelect: Bool) {
        self.title = title
        self.subtitle = subtitle
        self.details = details
        self.icon = icon
        self.isSelecting = isSelecting
        self.canSelect = canSelect
    }
}
