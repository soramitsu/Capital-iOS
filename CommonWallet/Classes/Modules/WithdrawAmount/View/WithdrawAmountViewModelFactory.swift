import Foundation

protocol WithdrawAmountViewModelFactoryProtocol {
    func createWithdrawTitle() -> String
    func createFeeTitle(for asset: WalletAsset?, amount: Decimal?) -> String
    func createAmountViewModel() -> AmountInputViewModel
    func createDescriptionViewModel() -> DescriptionInputViewModel
    func createAccessoryViewModel(for asset: WalletAsset?, totalAmount: Decimal?) -> AccessoryViewModel
}

final class WithdrawAmountViewModelFactory {
    let option: WalletWithdrawOption
    let amountFormatter: NumberFormatter
    let amountLimit: Decimal
    let descriptionMaxLength: UInt8

    init(amountFormatter: NumberFormatter,
         option: WalletWithdrawOption,
         amountLimit: Decimal,
         descriptionMaxLength: UInt8) {
        self.amountFormatter = amountFormatter
        self.option = option
        self.amountLimit = amountLimit
        self.descriptionMaxLength = descriptionMaxLength
    }
}

extension WithdrawAmountViewModelFactory: WithdrawAmountViewModelFactoryProtocol {
    func createWithdrawTitle() -> String {
        return "Send to \(option.symbol)"
    }

    func createFeeTitle(for asset: WalletAsset?, amount: Decimal?) -> String {
        let title: String = "Transaction fee"

        guard let amount = amount, let asset = asset else {
            return title
        }

        guard let amountString = amountFormatter.string(from: amount as NSNumber) else {
            return title
        }

        return title + " \(asset.symbol)\(amountString)"
    }

    func createAmountViewModel() -> AmountInputViewModel {
        return AmountInputViewModel(optionalAmount: nil, limit: amountLimit)
    }

    func createDescriptionViewModel() -> DescriptionInputViewModel {
        let placeholder = "Maximum \(descriptionMaxLength) symbols"
        return DescriptionInputViewModel(title: option.details,
                                         text: "",
                                         placeholder: placeholder,
                                         maxLength: descriptionMaxLength)
    }

    func createAccessoryViewModel(for asset: WalletAsset?, totalAmount: Decimal?) -> AccessoryViewModel {
        let accessoryViewModel = AccessoryViewModel(title: "", action: "Next")

        guard let amount = totalAmount, let asset = asset else {
            return accessoryViewModel
        }

        guard let amountString = amountFormatter.string(from: amount as NSNumber) else {
            return accessoryViewModel
        }

        accessoryViewModel.title = "Total amount \(asset.symbol)\(amountString)"

        return accessoryViewModel
    }
}
