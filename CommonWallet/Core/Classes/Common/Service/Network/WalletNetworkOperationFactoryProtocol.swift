/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood

public protocol WalletNetworkOperationFactoryProtocol {
    func fetchBalanceOperation(_ assets: [String]) -> CompoundOperationWrapper<[BalanceData]?>

    func fetchTransactionHistoryOperation(_ filter: WalletHistoryRequest,
                                          pagination: Pagination)
        -> CompoundOperationWrapper<AssetTransactionPageData?>

    func transferMetadataOperation(_ info: TransferMetadataInfo) -> CompoundOperationWrapper<TransferMetaData?>
    func transferOperation(_ info: TransferInfo) -> CompoundOperationWrapper<Data>
    func searchOperation(_ searchString: String) -> CompoundOperationWrapper<[SearchData]?>
    func contactsOperation() -> CompoundOperationWrapper<[SearchData]?>

    func withdrawalMetadataOperation(_ info: WithdrawMetadataInfo)
        -> CompoundOperationWrapper<WithdrawMetaData?>

    func withdrawOperation(_ info: WithdrawInfo) -> CompoundOperationWrapper<Data>
}
