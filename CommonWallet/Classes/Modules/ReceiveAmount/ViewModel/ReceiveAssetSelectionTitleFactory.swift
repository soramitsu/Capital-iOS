import Foundation

final class ReceiveAssetSelectionTitleFactory: AssetSelectionFactoryProtocol {
    
    func createTitle(for asset: WalletAsset?, balanceData: BalanceData?) -> String {
        guard let asset = asset else {
            return "No asset"
        }

        return "\(asset.identifier.name.uppercased()), \(asset.symbol)"
    }
    
}
