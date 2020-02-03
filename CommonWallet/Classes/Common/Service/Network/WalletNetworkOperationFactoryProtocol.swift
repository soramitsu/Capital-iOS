/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood
import IrohaCommunication

public protocol WalletNetworkOperationFactoryProtocol {
    func fetchBalanceOperation(_ assets: [IRAssetId]) -> BaseOperation<[BalanceData]?>
    func fetchTransactionHistoryOperation(_ filter: WalletHistoryRequest,
                                          pagination: OffsetPagination) -> BaseOperation<AssetTransactionPageData?>
    func transferMetadataOperation(_ info: TransferMetadataInfo) -> BaseOperation<TransferMetaData?>
    func transferOperation(_ info: TransferInfo) -> BaseOperation<Void>
    func searchOperation(_ searchString: String) -> BaseOperation<[SearchData]?>
    func contactsOperation() -> BaseOperation<[SearchData]?>
    func withdrawalMetadataOperation(_ info: WithdrawMetadataInfo) -> BaseOperation<WithdrawMetaData?>
    func withdrawOperation(_ info: WithdrawInfo) -> BaseOperation<Void>
}
