/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation

protocol FeeViewModelProtocol {
    var title: String { get }
    var details: String { get }
    var isLoading: Bool { get }
    var allowsEditing: Bool { get }
}

struct FeeViewModel: FeeViewModelProtocol {
    let title: String
    let details: String
    let isLoading: Bool
    let allowsEditing: Bool
}
