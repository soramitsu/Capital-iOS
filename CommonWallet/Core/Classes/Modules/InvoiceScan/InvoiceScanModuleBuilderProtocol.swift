/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


public protocol InvoiceScanModuleBuilderProtocol: class {
    @discardableResult
    func with(viewStyle: InvoiceScanViewStyleProtocol) -> Self

    @discardableResult
    func with(localSearchEngine: InvoiceLocalSearchEngineProtocol) -> Self

    @discardableResult
    func with(supportsUpload: Bool) -> Self
}
