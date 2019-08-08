import Foundation

final class LimitDescriptionValidator: WalletInputValidatorProtocol {
    private(set) var input: String = ""

    let hint: String

    let maxLength: UInt8

    var isValid: Bool {
        return true
    }

    init(maxLength: UInt8, hint: String) {
        self.maxLength = maxLength
        self.hint = hint
    }

    func didReceiveReplacement(_ string: String, for range: NSRange) -> Bool {
        let newLength = input.lengthOfBytes(using: .utf8) - range.length + string.lengthOfBytes(using: .utf8)
        guard maxLength == 0 || newLength <= maxLength else {
            return false
        }

        input = (input as NSString).replacingCharacters(in: range, with: string)

        return true
    }
}
