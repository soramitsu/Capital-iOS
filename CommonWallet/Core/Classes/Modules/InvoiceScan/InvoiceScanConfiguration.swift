/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


protocol InvoiceScanConfigurationProtocol {
    var viewStyle: InvoiceScanViewStyleProtocol { get }
    var supportsUpload: Bool { get }
}


struct InvoiceScanConfiguration: InvoiceScanConfigurationProtocol {
    var viewStyle: InvoiceScanViewStyleProtocol
    var supportsUpload: Bool
}
