/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication
import RobinHood

public protocol WalletNetworkOperationFactoryProtocol: class {
    func fetchBalanceOperation(_ urlTemplate: String, assets: [IRAssetId]) -> NetworkOperation<[BalanceData]?>
    func fetchTransactionHistoryOperation(_ urlTemplate: String,
                                          filter: WalletHistoryRequest,
                                          pagination: OffsetPagination) -> NetworkOperation<AssetTransactionPageData?>
    func transferMetadataOperation(_ urlTemplate: String, assetId: IRAssetId) -> NetworkOperation<TransferMetaData?>
    func transferOperation(_ urlTemplate: String, info: TransferInfo) -> NetworkOperation<Void>
    func searchOperation(_ urlTemplate: String, searchString: String) -> NetworkOperation<[SearchData]?>
    func contactsOperation(_ urlTemplate: String) -> NetworkOperation<[SearchData]?>
    func withdrawalMetadataOperation(_ urlTemplate: String,
                                     info: WithdrawMetadataInfo) -> NetworkOperation<WithdrawMetaData?>
    func withdrawOperation(_ urlTemplate: String, info: WithdrawInfo) -> NetworkOperation<Void>
}
