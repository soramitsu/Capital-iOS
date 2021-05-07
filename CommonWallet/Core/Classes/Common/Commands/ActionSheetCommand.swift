/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraFoundation

final class ActionSheetCommand<T>: WalletPresentationCommandProtocol {
    var presentationStyle: WalletPresentationStyle = .modal(inNavigation: false)
    var animated: Bool = true
    var completionBlock: (() -> Void)?

    let source: T
    let options: [WalletSelectableAction<T>]
    let resolver: ResolverProtocol
    let title: LocalizableResource<String>

    init(resolver: ResolverProtocol,
         source: T,
         title: LocalizableResource<String>,
         options: [WalletSelectableAction<T>]) {
        self.source = source
        self.title = title
        self.options = options
        self.resolver = resolver
    }

    func execute() throws {
        guard let navigator = resolver.navigation else {
            return
        }

        let locale = resolver.localizationManager?.selectedLocale ?? Locale.current
        let actionSheet = UIAlertController(title: title.value(for: locale),
                                            message: nil,
                                            preferredStyle: .actionSheet)

        for option in options {
            let action = UIAlertAction(title: option.title.value(for: locale), style: .default) { _ in
                option.action(self.source)
            }

            actionSheet.addAction(action)
        }

        actionSheet.addAction(UIAlertAction(title: L10n.Common.cancel, style: .cancel, handler: nil))

        present(view: actionSheet,
                in: navigator,
                animated: animated,
                completion: completionBlock)
    }
}
