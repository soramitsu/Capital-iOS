/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

@objc protocol DescriptionInputViewModelObserver: class {
    func descriptionInputDidChangeText()
}

protocol DescriptionInputViewModelProtocol: class {
    var text: String { get }
    var placeholder: String { get }
    var isValid: Bool { get }

    var observable: WalletViewModelObserverContainer<DescriptionInputViewModelObserver> { get }

    func didReceiveReplacement(_ string: String, for range: NSRange) -> Bool
}

final class DescriptionInputViewModel: DescriptionInputViewModelProtocol {
    var text: String {
        didSet {
            if text != oldValue {
                observable.observers.forEach { $0.observer?.descriptionInputDidChangeText() }
            }
        }
    }
    var placeholder: String
    var maxLength: UInt8

    var isValid: Bool {
        return true
    }

    var observable: WalletViewModelObserverContainer<DescriptionInputViewModelObserver>

    init(text: String, placeholder: String, maxLength: UInt8) {
        self.text = text
        self.placeholder = placeholder
        self.maxLength = maxLength

        observable = WalletViewModelObserverContainer()
    }

    func didReceiveReplacement(_ string: String, for range: NSRange) -> Bool {
        let newLength = text.count - range.length + string.count
        guard maxLength == 0 || newLength <= maxLength else {
            return false
        }

        text = (text as NSString).replacingCharacters(in: range, with: string)

        return true
    }
}
