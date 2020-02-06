/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication
import RobinHood

typealias BalanceCompletionBlock = (Result<[BalanceData]?, Error>?) -> Void
typealias TransactionHistoryBlock = (Result<AssetTransactionPageData?, Error>?) -> Void
typealias EmptyResultCompletionBlock = (Result<Void, Error>?) -> Void
typealias SearchCompletionBlock = (Result<[SearchData]?, Error>?) -> Void
typealias WithdrawalMetadataCompletionBlock = (Result<WithdrawMetaData?, Error>?) -> Void
typealias TransferMetadataCompletionBlock = (Result<TransferMetaData?, Error>?) -> Void

protocol WalletServiceProtocol {
    
    @discardableResult
    func fetchBalance(for assets: [IRAssetId],
                      runCompletionIn queue: DispatchQueue,
                      completionBlock: @escaping BalanceCompletionBlock) -> Operation

    @discardableResult
    func fetchTransactionHistory(for filter: WalletHistoryRequest,
                                 pagination: OffsetPagination,
                                 runCompletionIn queue: DispatchQueue,
                                 completionBlock: @escaping TransactionHistoryBlock) -> Operation

    @discardableResult
    func fetchTransferMetadata(for info: TransferMetadataInfo,
                               runCompletionIn queue: DispatchQueue,
                               completionBlock: @escaping TransferMetadataCompletionBlock) -> Operation

    @discardableResult
    func transfer(info: TransferInfo,
                  runCompletionIn queue: DispatchQueue,
                  completionBlock: @escaping EmptyResultCompletionBlock) -> Operation

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
    func withdraw(info: WithdrawInfo,
                  runCompletionIn queue: DispatchQueue,
                  completionBlock: @escaping EmptyResultCompletionBlock) -> Operation
}
