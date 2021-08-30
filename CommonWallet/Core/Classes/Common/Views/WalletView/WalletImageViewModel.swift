/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol WalletImageViewModelProtocol: AnyObject {
    var image: UIImage? { get }
    func loadImage(with completionBlock: @escaping (UIImage?, Error?) -> Void)
    func cancel()
}
