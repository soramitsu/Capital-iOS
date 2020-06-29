/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol WalletFormItemViewFactoryOverriding {
    func createDetailsFormView() -> (WalletFormItemView & WalletFormDetailsViewProtocol)?
    func createFormTitleIconView() -> (WalletFormItemView & WalletFormTitleIconViewProtocol)?
    func createTokenView() -> (WalletFormItemView & WalletFormTokenViewProtocol)?
}

public extension WalletFormItemViewFactoryOverriding {
    func createDetailsFormView() -> (WalletFormItemView & WalletFormDetailsViewProtocol)? {
        nil
    }

    func createFormTitleIconView() -> (WalletFormItemView & WalletFormTitleIconViewProtocol)? {
        nil
    }

    func createTokenView() -> (WalletFormItemView & WalletFormTokenViewProtocol)? {
        nil
    }
}

struct WalletFormItemViewFactoryWrapper: WalletFormItemViewFactoryProtocol {
    let overriding: WalletFormItemViewFactoryOverriding
    let defaultFactory: WalletFormItemViewFactoryProtocol

    func createDetailsFormView() -> WalletFormItemView & WalletFormDetailsViewProtocol {
        overriding.createDetailsFormView() ?? defaultFactory.createDetailsFormView()
    }

    func createFormTitleIconView() -> WalletFormItemView & WalletFormTitleIconViewProtocol {
        overriding.createFormTitleIconView() ?? defaultFactory.createFormTitleIconView()
    }

    func createTokenView() -> WalletFormItemView & WalletFormTokenViewProtocol {
        overriding.createTokenView() ?? defaultFactory.createTokenView()
    }
}
