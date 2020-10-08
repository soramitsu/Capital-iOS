/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public typealias BaseAccountDetailsContainingView = UIView & AccountDetailsContainingViewProtocol

public protocol AccountDetailsContainingViewProtocol: class {
    var contentInsets: UIEdgeInsets { get }
    var preferredContentHeight: CGFloat { get }

    func setContentInsets(_ contentInsets: UIEdgeInsets, animated: Bool)
    func bind(viewModels: [WalletViewModelProtocol])
}
