/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

enum InvoiceScanModuleBuilderError: Error {}


final class InvoiceScanModuleBuilder {
    lazy var walletStyle: WalletStyleProtocol = WalletStyle()

    var supportsUpload: Bool = true

    fileprivate lazy var viewStyle: InvoiceScanViewStyleProtocol = {
        return InvoiceScanViewStyle.createDefaultStyle(with: walletStyle)
    }()

    func build() -> InvoiceScanConfigurationProtocol {
        return InvoiceScanConfiguration(viewStyle: viewStyle,
                                        supportsUpload: supportsUpload)
    }
}


extension InvoiceScanModuleBuilder: InvoiceScanModuleBuilderProtocol {
    func with(viewStyle: InvoiceScanViewStyleProtocol) -> Self {
        self.viewStyle = viewStyle
        return self
    }

    func with(supportsUpload: Bool) -> Self {
        self.supportsUpload = supportsUpload
        return self
    }
}
