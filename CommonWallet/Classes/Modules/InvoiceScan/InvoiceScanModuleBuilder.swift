/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

enum InvoiceScanModuleBuilderError: Error {}


final class InvoiceScanModuleBuilder {
    lazy var walletStyle: WalletStyleProtocol = WalletStyle()

    fileprivate lazy var viewStyle: InvoiceScanViewStyleProtocol = {
        return InvoiceScanViewStyle.createDefaultStyle(with: walletStyle)
    }()

    func build() -> InvoiceScanConfigurationProtocol {
        return InvoiceScanConfiguration(viewStyle: viewStyle)
    }
}


extension InvoiceScanModuleBuilder: InvoiceScanModuleBuilderProtocol {
    func with(viewStyle: InvoiceScanViewStyleProtocol) -> Self {
        self.viewStyle = viewStyle
        return self
    }
}
