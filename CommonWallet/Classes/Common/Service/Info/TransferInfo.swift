import Foundation
import IrohaCommunication

struct TransferInfo {
    var source: IRAccountId
    var destination: IRAccountId
    var amount: IRAmount
    var asset: IRAssetId
    var details: String
}
