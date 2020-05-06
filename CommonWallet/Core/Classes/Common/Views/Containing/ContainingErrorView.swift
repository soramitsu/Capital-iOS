/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import UIKit

final class ContainingErrorView: MultilineTitleIconView {
    func bind(errorMessage: String) {
        self.title = errorMessage
    }
}
