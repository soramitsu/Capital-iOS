/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public struct SelectedAssetState {
    let isSelecting: Bool
    let canSelect: Bool

    public init(isSelecting: Bool, canSelect: Bool) {
        self.isSelecting = isSelecting
        self.canSelect = canSelect
    }
}

public protocol AssetSelectionViewModelProtocol {
    var title: String { get }
    var subtitle: String { get }
    var details: String { get }
    var icon: UIImage? { get }
    var state: SelectedAssetState { get }
}

public struct AssetSelectionViewModel: AssetSelectionViewModelProtocol {
    public let title: String
    public let subtitle: String
    public let details: String
    public let icon: UIImage?
    public let state: SelectedAssetState

    public init(title: String,
                subtitle: String,
                details: String,
                icon: UIImage?,
                state: SelectedAssetState) {
        self.title = title
        self.subtitle = subtitle
        self.details = details
        self.icon = icon
        self.state = state
    }
}
