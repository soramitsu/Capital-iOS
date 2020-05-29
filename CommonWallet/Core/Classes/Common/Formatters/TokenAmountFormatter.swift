/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraFoundation

public enum TokenSymbolPosition {
    case prefix
    case suffix
}

open class TokenAmountFormatter {
    let numberFormatter: NumberFormatter
    let tokenSymbol: String
    let separator: String
    let position: TokenSymbolPosition

    public var locale: Locale {
        get {
            numberFormatter.locale
        }

        set {
            numberFormatter.locale = newValue
        }
    }

    public init(numberFormatter: NumberFormatter,
                tokenSymbol: String,
                separator: String = "",
                position: TokenSymbolPosition = .prefix) {
        self.numberFormatter = numberFormatter
        self.tokenSymbol = tokenSymbol
        self.separator = separator
        self.position = position
    }

    public func string(from amount: Decimal) -> String? {
        guard let formattedAmount = numberFormatter.string(from: amount as NSNumber) else {
            return nil
        }

        switch position {
        case .prefix:
            return "\(tokenSymbol)\(separator)\(formattedAmount)"
        case .suffix:
            return "\(formattedAmount)\(separator)\(tokenSymbol)"
        }
    }
}

extension TokenAmountFormatter {
    public func localizableResource() -> LocalizableResource<TokenAmountFormatter> {
        LocalizableResource { locale in
            self.locale = locale
            return self
        }
    }
}
