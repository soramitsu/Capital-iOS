/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit

extension DefaultEmptyStateDataSource {
    static var history: DefaultEmptyStateDataSource {
        let title = "Incoming and outgoing\ntransactions will appear here"
        let image = UIImage(named: "iconHistoryEmptyState")
        return DefaultEmptyStateDataSource(title: title,
                                           image: image)
    }

    static var contacts: DefaultEmptyStateDataSource {
        let title = "Your favorite recipients will appear here"
        let image = UIImage(named: "iconSearchEmptyState")
        return DefaultEmptyStateDataSource(title: title, image: image)
    }

    static var search: DefaultEmptyStateDataSource {
        let title = "No search result"
        let image = UIImage(named: "iconSearchEmptyState")
        return DefaultEmptyStateDataSource(title: title, image: image)
    }
}
