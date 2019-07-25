/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication
import RobinHood

protocol WalletServiceOperationFactoryProtocol: class {
    func fetchBalanceOperation(_ urlTemplate: String, assets: [IRAssetId]) -> NetworkOperation<[BalanceData]>
    func fetchTransactionHistoryOperation(_ urlTemplate: String,
                                          filter: WalletHistoryRequest,
                                          pagination: OffsetPagination) -> NetworkOperation<AssetTransactionPageData>
    func transferOperation(_ urlTemplate: String, info: TransferInfo) -> NetworkOperation<Bool>
    func searchOperation(_ urlTemplate: String, searchString: String) -> NetworkOperation<[SearchData]>
    func contactsOperation(_ urlTemplate: String) -> NetworkOperation<[SearchData]>
}
