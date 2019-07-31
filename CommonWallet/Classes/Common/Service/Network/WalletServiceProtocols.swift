/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication
import RobinHood

typealias BalanceCompletionBlock = (OperationResult<[BalanceData]>?) -> Void
typealias TransactionHistoryBlock = (OperationResult<AssetTransactionPageData>?) -> Void
typealias BoolResultCompletionBlock = (OperationResult<Bool>?) -> Void
typealias SearchCompletionBlock = (OperationResult<[SearchData]>?) -> Void
typealias WithdrawalMetadataCompletionBlock = (OperationResult<WithdrawalData>?) -> Void

protocol WalletServiceProtocol {
    
    @discardableResult
    func fetchBalance(for assets: [IRAssetId],
                      runCompletionIn queue: DispatchQueue,
                      completionBlock: @escaping BalanceCompletionBlock) -> Operation

    @discardableResult
    func fetchTransactionHistory(for filter: WalletHistoryRequest,
                                 pagination: OffsetPagination,
                                 runCompletionIn queue: DispatchQueue,
                                 completionBlock: @escaping TransactionHistoryBlock) throws -> Operation

    @discardableResult
    func transfer(info: TransferInfo,
                  runCompletionIn queue: DispatchQueue,
                  completionBlock: @escaping BoolResultCompletionBlock) -> Operation

    @discardableResult
    func search(for searchString: String,
                runCompletionIn queue: DispatchQueue,
                completionBlock: @escaping SearchCompletionBlock) -> Operation
    
    @discardableResult
    func fetchContacts(runCompletionIn queue: DispatchQueue,
                       completionBlock: @escaping SearchCompletionBlock) -> Operation

    @discardableResult
    func fetchWithdrawalMetadata(for info: WithdrawMetadataInfo,
                                 runCompletionIn queue: DispatchQueue,
                                 completionBlock: @escaping WithdrawalMetadataCompletionBlock) -> Operation

    @discardableResult
    func withdraw(info: TransferInfo,
                  runCompletionIn queue: DispatchQueue,
                  completionBlock: @escaping BoolResultCompletionBlock) -> Operation
}
