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

        return Decimal(string: amount, locale: Locale.current)
    }

    var isValid: Bool {
        if let value = Decimal(string: amount, locale: Locale.current), value > 0 {
            return true
        } else {
            return false
        }
    }

    private(set) var amount: String {
        didSet {
            if amount != oldValue {
                observable.observers.forEach { $0.observer?.amountInputDidChange() }
            }
        }
    }

    let limit: Decimal

    var observable: WalletViewModelObserverContainer<AmountInputViewModelObserver>

    init(optionalAmount: Decimal?, limit: Decimal) {
        if let amount = optionalAmount {
            if amount <= limit {
                self.amount = NumberFormatter.moneyFormatter.string(from: amount as NSNumber)
                    ?? AmountInputViewModel.zero
            } else {
                self.amount = AmountInputViewModel.zero
            }
        } else {
            self.amount = ""
        }

        self.limit = limit

        observable = WalletViewModelObserverContainer()
    }

    func didReceiveReplacement(_ string: String, for range: NSRange) -> Bool {
        var newAmount = displayAmount

        if range.location == newAmount.count, string.count > 0 {
            newAmount = add(string)
        } else {
            newAmount = (newAmount as NSString).replacingCharacters(in: range, with: string)

            newAmount = set(newAmount)
        }

        let optionalAmountDecimal = !newAmount.isEmpty ? Decimal(string: newAmount, locale: Locale.current) : Decimal(0)

        guard
            let receivedAmountDecimal = optionalAmountDecimal,
            receivedAmountDecimal <= limit else {
            return false
        }

        amount = newAmount

        return false
    }
}
