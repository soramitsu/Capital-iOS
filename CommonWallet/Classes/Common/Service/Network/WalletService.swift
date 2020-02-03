/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication

enum WalletServiceError: Error {
    case invalidPageHash
}

final class WalletService {
    let operationQueue: OperationQueue
    let operationFactory: WalletNetworkOperationFactoryProtocol

    init(operationFactory: WalletNetworkOperationFactoryProtocol,
         operationQueue: OperationQueue = OperationQueue()) {
        self.operationFactory = operationFactory
        self.operationQueue = operationQueue
    }
}

extension WalletService: WalletServiceProtocol {

    @discardableResult
    func fetchBalance(for assets: [IRAssetId],
                      runCompletionIn queue: DispatchQueue,
                      completionBlock: @escaping BalanceCompletionBlock) -> Operation {
        let operation = operationFactory.fetchBalanceOperation(assets)

        operation.completionBlock = {
            queue.async {
                completionBlock(operation.result)
            }
        }

        operationQueue.addOperation(operation)

        return operation
    }

    @discardableResult
    func fetchTransactionHistory(for filter: WalletHistoryRequest,
                                 pagination: OffsetPagination,
                                 runCompletionIn queue: DispatchQueue,
                                 completionBlock: @escaping TransactionHistoryBlock) -> Operation {

        let operation = operationFactory.fetchTransactionHistoryOperation(filter, pagination: pagination)

        operation.completionBlock = {
            queue.async {
                completionBlock(operation.result)
            }
        }

        operationQueue.addOperation(operation)

        return operation
    }

    @discardableResult
    func fetchTransferMetadata(for info: TransferMetadataInfo,
                               runCompletionIn queue: DispatchQueue,
                               completionBlock: @escaping TransferMetadataCompletionBlock) -> Operation {

        let operation = operationFactory.transferMetadataOperation(info)

        operation.completionBlock = {
            queue.async {
                completionBlock(operation.result)
            }
        }

        operationQueue.addOperation(operation)

        return operation
    }

    @discardableResult
    func transfer(info: TransferInfo,
                  runCompletionIn queue: DispatchQueue,
                  completionBlock: @escaping EmptyResultCompletionBlock) -> Operation {

        let operation = operationFactory.transferOperation(info)

        operation.completionBlock = {
            queue.async {
                completionBlock(operation.result)
            }
        }

        operationQueue.addOperation(operation)

        return operation
    }

    @discardableResult
    func search(for searchString: String,
                runCompletionIn queue: DispatchQueue,
                completionBlock: @escaping SearchCompletionBlock) -> Operation {

        let operation = operationFactory.searchOperation(searchString)

        operation.completionBlock = {
            queue.async {
                completionBlock(operation.result)
            }
        }

        operationQueue.addOperation(operation)

        return operation
    }

    @discardableResult
    func fetchContacts(runCompletionIn queue: DispatchQueue,
                       completionBlock: @escaping SearchCompletionBlock) -> Operation {
        let operation = operationFactory.contactsOperation()
        
        operation.completionBlock = {
            queue.async {
                completionBlock(operation.result)
            }
        }
        
        operationQueue.addOperation(operation)
        
        return operation
    }

    @discardableResult
    func fetchWithdrawalMetadata(for info: WithdrawMetadataInfo,
                                 runCompletionIn queue: DispatchQueue,
                                 completionBlock: @escaping WithdrawalMetadataCompletionBlock) -> Operation {
        let operation = operationFactory.withdrawalMetadataOperation(info)

        operation.completionBlock = {
            queue.async {
                completionBlock(operation.result)
            }
        }

        operationQueue.addOperation(operation)

        return operation
    }

    @discardableResult
    func withdraw(info: WithdrawInfo,
                  runCompletionIn queue: DispatchQueue,
                  completionBlock: @escaping EmptyResultCompletionBlock) -> Operation {
        let operation = operationFactory.withdrawOperation(info)

        operation.completionBlock = {
            queue.async {
                completionBlock(operation.result)
            }
        }

        operationQueue.addOperation(operation)

        return operation
    }
}
