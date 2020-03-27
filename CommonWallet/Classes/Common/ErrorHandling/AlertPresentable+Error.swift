/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

extension AlertPresentable {
    func showError(_ error: WalletErrorContentProtocol) {
        showAlert(title: error.title,
                  message: error.message,
                  actions: [(L10n.Common.close, .cancel)],
                  completion: { _ in })
    }

    func attemptShowError(_ error: Error, locale: Locale?) -> Bool {
        guard let contentConvertible = error as? WalletErrorContentConvertible else {
            return false
        }

        let content = contentConvertible.toErrorContent(for: locale)

        showError(content)

        return true
    }
}
