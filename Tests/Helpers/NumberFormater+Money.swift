import Foundation

extension NumberFormatter {
    static func money(with precision: UInt8) -> NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = Int(precision)
        return numberFormatter
    }
}
