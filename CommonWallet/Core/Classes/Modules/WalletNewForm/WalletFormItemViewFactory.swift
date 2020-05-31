/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraUI

public protocol WalletFormBordering: class {
    var borderType: BorderType { get set }
}

public typealias WalletFormItemView = UIView & WalletFormBordering

public protocol WalletFormItemViewFactoryProtocol {
    func createDetailsFormView() -> WalletFormItemView & WalletFormDetailsViewProtocol
    func createFormTitleIconView() -> WalletFormItemView & WalletFormTitleIconViewProtocol
}

class WalletFormItemViewFactory: WalletFormItemViewFactoryProtocol {
    func createDetailsFormView() -> WalletFormItemView & WalletFormDetailsViewProtocol {
        WalletFormDetailsView()
    }

    func createFormTitleIconView() -> WalletFormItemView & WalletFormTitleIconViewProtocol {
        WalletFormTitleIconView()
    }
}
