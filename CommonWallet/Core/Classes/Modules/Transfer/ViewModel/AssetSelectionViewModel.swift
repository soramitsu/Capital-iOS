/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

protocol AssetSelectionViewModelProtocol {
    var title: String { get }
    var details: String { get }
    var icon: UIImage? { get }
    var isSelecting: Bool { get }
    var canSelect: Bool { get }
}

struct AssetSelectionViewModel: AssetSelectionViewModelProtocol {
    let title: String
    let details: String
    let icon: UIImage?
    let isSelecting: Bool
    let canSelect: Bool
}
