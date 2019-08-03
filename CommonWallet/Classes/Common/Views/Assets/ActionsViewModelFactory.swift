import Foundation
import IrohaCommunication

public typealias ActionsViewModelFactory = (WalletCommandFactoryProtocol, IRAssetId?) throws -> ActionsViewModelProtocol
