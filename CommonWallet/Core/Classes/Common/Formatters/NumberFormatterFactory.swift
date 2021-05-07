/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation

public protocol NumberFormatterFactoryProtocol {
    func createInputFormatter(for asset: WalletAsset?) -> LocalizableResource<NumberFormatter>
    func createDisplayFormatter(for asset: WalletAsset?) -> LocalizableResource<NumberFormatter>
    func createTokenFormatter(for asset: WalletAsset?) -> LocalizableResource<TokenFormatter>
}

public extension NumberFormatterFactoryProtocol {
    func createInputFormatter(for asset: WalletAsset?) -> LocalizableResource<NumberFormatter> {
        let numberFormatter = NumberFormatter()
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.numberStyle = .decimal

        if let asset = asset {
            numberFormatter.maximumFractionDigits = Int(asset.precision)
        }

        numberFormatter.roundingMode = .down

        return numberFormatter.localizableResource()
    }

    func createDisplayFormatter(for asset: WalletAsset?) -> LocalizableResource<NumberFormatter> {
        createDisplayNumberFormatter(for: asset).localizableResource()
    }

    func createTokenFormatter(for asset: WalletAsset?) -> LocalizableResource<TokenFormatter> {
        let numberFormatter = createDisplayNumberFormatter(for: asset)

        let formatter = TokenFormatter(decimalFormatter: numberFormatter, tokenSymbol: asset?.symbol ?? "")

        return LocalizableResource { locale in
            formatter.locale = locale
            return formatter
        }
    }

    private func createDisplayNumberFormatter(for asset: WalletAsset?) -> NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.numberStyle = .decimal

        if let asset = asset {
            numberFormatter.maximumFractionDigits = Int(asset.precision)
        }

        numberFormatter.roundingMode = .down

        return numberFormatter
    }
}

struct NumberFormatterFactory: NumberFormatterFactoryProtocol {}
