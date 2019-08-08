/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

@objc protocol DescriptionInputViewModelObserver: class {
    func descriptionInputDidChangeText()
}

protocol DescriptionInputViewModelProtocol: class {
    var title: String { get }
    var text: String { get }
    var placeholder: String { get }
    var isValid: Bool { get }

    var observable: WalletViewModelObserverContainer<DescriptionInputViewModelObserver> { get }

    func didReceiveReplacement(_ string: String, for range: NSRange) -> Bool
}

final class DescriptionInputViewModel: DescriptionInputViewModelProtocol {
    var title: String

    var text: String {
        return validator.input
    }

    var placeholder: String {
        return validator.hint
    }

    var isValid: Bool {
        return validator.isValid
    }

    let validator: WalletInputValidatorProtocol

    var observable: WalletViewModelObserverContainer<DescriptionInputViewModelObserver>

    init(title: String, validator: WalletInputValidatorProtocol) {
        self.title = title
        self.validator = validator

        observable = WalletViewModelObserverContainer()
    }

    func didReceiveReplacement(_ string: String, for range: NSRange) -> Bool {
        let applied = validator.didReceiveReplacement(string, for: range)

        observable.observers.forEach { $0.observer?.descriptionInputDidChangeText() }

        return applied
    }
}
