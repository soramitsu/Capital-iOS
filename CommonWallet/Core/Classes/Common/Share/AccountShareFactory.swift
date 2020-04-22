/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import UIKit

public protocol AccountShareFactoryProtocol {
    func createSources(for receiveInfo: ReceiveInfo, qrImage: UIImage) -> [Any]
}

struct AccountShareFactory: AccountShareFactoryProtocol {
    func createSources(for receiveInfo: ReceiveInfo, qrImage: UIImage) -> [Any] {
        return [qrImage, L10n.Common.accountShare, receiveInfo.accountId]
    }
}
