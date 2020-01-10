/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


protocol MoneyPresentable {
    var formatter: NumberFormatter { get }
    var amount: String { get }

    func transform(input: String, from locale: Locale) -> String
}

private struct MoneyPresentableConstants {
    static let doubleZero = "00"
    static let singleZero = "0"
}

extension MoneyPresentable {
    
    var formattedAmount: String? {
        guard !amount.isEmpty else {
            return ""
        }

        guard let decimalAmount = Decimal(string: amount, locale: formatter.locale) else {
            return nil
        }

        var amountFormatted = formatter.string(from: decimalAmount as NSDecimalNumber)
        let separator = decimalSeparator()

        if amount.hasSuffix(separator) {
            amountFormatted?.append(separator)
        } else {
            let parts = amount.components(separatedBy: separator)
            if parts.count == 2 && parts[1] == MoneyPresentableConstants.doubleZero {
                amountFormatted?.append("\(separator)\(MoneyPresentableConstants.doubleZero)")
            } else if parts.count == 2 && parts[1] == MoneyPresentableConstants.singleZero {
                amountFormatted?.append("\(separator)\(MoneyPresentableConstants.singleZero)")
            } else if parts.count == 2 && parts[1].hasSuffix("\(MoneyPresentableConstants.singleZero)") {
                amountFormatted?.append("\(MoneyPresentableConstants.singleZero)")
            }
        }
        
        return amountFormatted
    }

    private func decimalSeparator() -> String {
        return formatter.decimalSeparator!
    }
    
    private func groupingSeparator() -> String {
        return formatter.groupingSeparator!
    }
    
    private func notEligibleSet() -> CharacterSet {
        return CharacterSet.decimalDigits
            .union(CharacterSet(charactersIn: "\(decimalSeparator())\(groupingSeparator())")).inverted
    }

    func add(_ amount: String) -> String {
        guard amount.rangeOfCharacter(from: notEligibleSet()) == nil else {
            return self.amount
        }

        var newAmount = (self.amount + amount).replacingOccurrences(of: groupingSeparator(),
                                                                    with: "")

        if newAmount.hasPrefix(decimalSeparator()) {
            newAmount = "\(MoneyPresentableConstants.singleZero)\(newAmount)"
        }

        let newAmountComponents = newAmount.components(separatedBy: decimalSeparator())

        if newAmountComponents.count > 2 || (newAmountComponents.count == 2 && newAmountComponents[1].count > 2) {
            return self.amount
        }

        return newAmount
    }

    func set(_ amount: String) -> String {
        guard amount.rangeOfCharacter(from: notEligibleSet()) == nil else {
            return self.amount
        }

        var settingAmount = amount.replacingOccurrences(of: groupingSeparator(),
                                                        with: "")

        if settingAmount.hasPrefix(decimalSeparator()) {
            settingAmount = "\(MoneyPresentableConstants.singleZero)\(settingAmount)"
        }

        let settingAmountComponents = settingAmount.components(separatedBy: decimalSeparator())

        if settingAmountComponents.count > 2 ||
            (settingAmountComponents.count == 2 && settingAmountComponents[1].count > 2) {
            return self.amount
        }
        
        return settingAmount
    }

    func transform(input: String, from locale: Locale) -> String {
        var result = input

        if let localeGroupingSeparator = locale.groupingSeparator {
            result = result.replacingOccurrences(of: localeGroupingSeparator, with: "")
        }

        if let localeDecimalSeparator = locale.decimalSeparator,
            localeDecimalSeparator != decimalSeparator() {
            result = result.replacingOccurrences(of: localeDecimalSeparator,
                                                 with: decimalSeparator())
        }

        return result
    }
}

