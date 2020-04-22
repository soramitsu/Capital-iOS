import Foundation

extension NSDecimalNumberHandler {
    static func defaultHandler(precision: Int16) -> NSDecimalNumberHandler {
        NSDecimalNumberHandler(roundingMode: .up,
                               scale: Int16(precision),
                               raiseOnExactness: false,
                               raiseOnOverflow: true,
                               raiseOnUnderflow: true,
                               raiseOnDivideByZero: true)
    }
}
