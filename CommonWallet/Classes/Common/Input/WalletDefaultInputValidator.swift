/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public final class WalletDefaultInputValidator {
    public private(set) var input: String = ""
    public let hint: String

    let invalidCharset: CharacterSet?
    let maxLength: UInt8
    let predicate: NSPredicate?

    public init(hint: String, maxLength: UInt8, validCharset: CharacterSet? = nil, predicate: NSPredicate? = nil) {
        self.hint = hint
        self.maxLength = maxLength
        self.invalidCharset = validCharset?.inverted
        self.predicate = predicate
    }
}

extension WalletDefaultInputValidator: WalletInputValidatorProtocol {
    public var isValid: Bool {
        return predicate?.evaluate(with: input) ?? true
    }

    public func didReceiveReplacement(_ string: String, for range: NSRange) -> Bool {
        let newLength = input.lengthOfBytes(using: .utf8) - range.length + string.lengthOfBytes(using: .utf8)
        guard maxLength == 0 || newLength <= maxLength else {
            return false
        }

        if let charset = invalidCharset, string.rangeOfCharacter(from: charset) != nil {
            return false
        }

        input = (input as NSString).replacingCharacters(in: range, with: string)

        return true
    }
}
