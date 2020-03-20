/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public enum WalletInputLengthMetric {
    case utf8byte
    case character
}

public final class WalletDefaultInputValidator {
    public private(set) var input: String = ""
    public let hint: String

    let invalidCharset: CharacterSet?
    let maxLength: UInt8
    let predicate: NSPredicate?
    let lengthMetric: WalletInputLengthMetric

    public init(hint: String,
                maxLength: UInt8,
                validCharset: CharacterSet? = nil,
                predicate: NSPredicate? = nil,
                lengthMetric: WalletInputLengthMetric = .utf8byte) {
        self.hint = hint
        self.maxLength = maxLength
        self.invalidCharset = validCharset?.inverted
        self.predicate = predicate
        self.lengthMetric = lengthMetric
    }
}

extension WalletDefaultInputValidator: WalletInputValidatorProtocol {
    public var isValid: Bool {
        return predicate?.evaluate(with: input) ?? true
    }

    public func didReceiveReplacement(_ string: String, for range: NSRange) -> Bool {
        if let charset = invalidCharset, string.rangeOfCharacter(from: charset) != nil {
            return false
        }

        let newInput = (input as NSString).replacingCharacters(in: range, with: string)

        if maxLength > 0 {
            switch lengthMetric {
            case .utf8byte:
                if newInput.lengthOfBytes(using: .utf8) > maxLength {
                    return false
                }
            case .character:
                if newInput.count > maxLength {
                    return false
                }
            }
        }

        input = newInput

        return true
    }
}
