import Foundation
import IrohaCommunication

final class AssetDetailsCommand {
    let resolver: ResolverProtocol
    let assetId: IRAssetId

    init(resolver: ResolverProtocol, assetId: IRAssetId) {
        self.resolver = resolver
        self.assetId = assetId
    }
}

extension AssetDetailsCommand: WalletCommandProtocol {
    func execute() throws {
        guard resolver.account.assets.count > 1 else {
            return
        }

        guard let asset = resolver.account.asset(for: assetId.identifier()) else {
                resolver.logger?.error("Can't find asset to open details")
            return
        }

        guard let assetDetailsView = AccountDetailsAssembly.assembleView(with: resolver,
                                                                         asset: asset) else {
            return
        }

        assetDetailsView.controller.hidesBottomBarWhenPushed = true
        resolver.navigation?.push(assetDetailsView.controller)
    }
}
