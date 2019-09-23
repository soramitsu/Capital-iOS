import Foundation
import UIKit

public protocol AccountShareFactoryProtocol {
    func createSources(for receiveInfo: ReceiveInfo, qrImage: UIImage) -> [Any]
}

struct AccountShareFactory: AccountShareFactoryProtocol {
    func createSources(for receiveInfo: ReceiveInfo, qrImage: UIImage) -> [Any] {
        return [qrImage, "My account is:", receiveInfo.accountId.identifier()]
    }
}
