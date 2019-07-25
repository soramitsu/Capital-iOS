/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


extension NumberFormatter {
    
    static var moneyFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = Locale.current.groupingSeparator
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = Locale.current.decimalSeparator
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }
    
}


protocol MoneyPresentable {
    
    var amount: String { get }
    
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

        guard let decimalAmount = Decimal(string: amount, locale: Locale.current) else {
            return nil
        }

        var amountFormatted = NumberFormatter.moneyFormatter.string(from: decimalAmount as NSDecimalNumber)
        let separator = self.separator()

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

    private func separator() -> String {
        return Locale.current.decimalSeparator!
    }
    
    private func groupingSeparator() -> String {
        return Locale.current.groupingSeparator!
    }
    
    private func notEligibleSet() -> CharacterSet {
        return CharacterSet.decimalDigits
            .union(CharacterSet(charactersIn: "\(separator()) \(groupingSeparator())")).inverted
    }
    
    func add(_ amount: String) -> String {
        guard amount.rangeOfCharacter(from: notEligibleSet()) == nil else {
            return self.amount
        }

        var newAmount = self.amount + amount

        if newAmount.hasPrefix(separator()) {
            newAmount = "\(MoneyPresentableConstants.singleZero)\(newAmount)"
        }

        let newAmountComponents = newAmount.components(separatedBy: separator())

        if newAmountComponents.count > 2 || (newAmountComponents.count == 2 && newAmountComponents[1].count > 2) {
            return self.amount
        }

        newAmount = newAmount.replacingOccurrences(of: Locale.current.groupingSeparator!, with: "")

        return newAmount
    }
    
    func set(_ amount: String) -> String {
        var settingAmount = amount

        if settingAmount.contains(".") && separator() != "." {
            settingAmount = settingAmount.replacingOccurrences(of: ".", with: separator())
        }

        guard settingAmount.rangeOfCharacter(from: notEligibleSet()) == nil else {
            return self.amount
        }

        if settingAmount.hasPrefix(separator()) {
            settingAmount = "\(MoneyPresentableConstants.singleZero)\(settingAmount)"
        }

        let settingAmountComponents = settingAmount.components(separatedBy: separator())

        if settingAmountComponents.count > 2 ||
            (settingAmountComponents.count == 2 && settingAmountComponents[1].count > 2) {
            return self.amount
        }
        
        let newAmount = settingAmount.replacingOccurrences(of: Locale.current.groupingSeparator!, with: "")
        
        return newAmount
    }
    
}

