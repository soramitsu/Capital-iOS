/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

@objc public protocol DescriptionInputViewModelObserver: class {
    func descriptionInputDidChangeText()
}

public protocol DescriptionInputViewModelProtocol: class {
    var text: String { get }
    var placeholder: String { get }
    var isValid: Bool { get }

    var observable: WalletViewModelObserverContainer<DescriptionInputViewModelObserver> { get }

    func didReceiveReplacement(_ string: String, for range: NSRange) -> Bool
}

public final class DescriptionInputViewModel: DescriptionInputViewModelProtocol {

    public var text: String {
        return validator.input
    }

    public var placeholder: String {
        return validator.hint
    }

    public var isValid: Bool {
        return validator.isValid
    }

    let validator: WalletInputValidatorProtocol

    public var observable: WalletViewModelObserverContainer<DescriptionInputViewModelObserver>

    public init(validator: WalletInputValidatorProtocol) {
        self.validator = validator

        observable = WalletViewModelObserverContainer()
    }

    public func didReceiveReplacement(_ string: String, for range: NSRange) -> Bool {
        let applied = validator.didReceiveReplacement(string, for: range)

        observable.observers.forEach { $0.observer?.descriptionInputDidChangeText() }

        return applied
    }
}
