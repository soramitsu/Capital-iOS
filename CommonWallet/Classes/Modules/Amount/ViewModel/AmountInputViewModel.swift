/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

@objc protocol AmountInputViewModelObserver: class {
    func amountInputDidChange()
}

protocol AmountInputViewModelProtocol: class {
    var displayAmount: String { get }
    var isValid: Bool { get }
    var observable: WalletViewModelObserverContainer<AmountInputViewModelObserver> { get }

    func didReceiveReplacement(_ string: String, for range: NSRange) -> Bool
}


final class AmountInputViewModel: AmountInputViewModelProtocol, MoneyPresentable {
    static let zero: String = "0"

    var displayAmount: String {
        return formattedAmount ?? AmountInputViewModel.zero
    }

    var decimalAmount: Decimal? {
        if amount.isEmpty {
            return Decimal(0)
        }

        return Decimal(string: amount, locale: formatter.locale)
    }

    var isValid: Bool {
        if let value = Decimal(string: amount, locale: formatter.locale), value > 0 {
            return true
        } else {
            return false
        }
    }

    var precision: Int16

    private(set) var amount: String = "" {
        didSet {
            if amount != oldValue {
                observable.observers.forEach { $0.observer?.amountInputDidChange() }
            }
        }
    }

    let formatter: NumberFormatter

    let inputLocale: Locale

    let limit: Decimal

    var observable: WalletViewModelObserverContainer<AmountInputViewModelObserver>

    init(amount: Decimal?,
         limit: Decimal,
         formatter: NumberFormatter,
         inputLocale: Locale = Locale.current,
         precision: Int16 = 2) {
        self.limit = limit
        self.formatter = formatter
        self.inputLocale = inputLocale
        self.precision = precision

        observable = WalletViewModelObserverContainer()

        if let amount = amount, amount <= limit,
            let inputAmount = formatter.string(from: amount as NSNumber) {
            self.amount = set(inputAmount)
        }
    }

    func didReceiveReplacement(_ string: String, for range: NSRange) -> Bool {
        let replacement = transform(input: string, from: inputLocale)

        var newAmount = displayAmount

        if range.location == newAmount.count {
            newAmount = add(replacement)
        } else {
            newAmount = (newAmount as NSString).replacingCharacters(in: range, with: replacement)
            newAmount = set(newAmount)
        }

        let optionalAmountDecimal = !newAmount.isEmpty ?
            Decimal(string: newAmount, locale: formatter.locale) :
            Decimal.zero

        guard
            let receivedAmountDecimal = optionalAmountDecimal,
            receivedAmountDecimal <= limit else {
            return false
        }

        amount = newAmount

        return false
    }
}
