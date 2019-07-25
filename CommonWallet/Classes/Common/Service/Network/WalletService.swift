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
    let operationFactory: WalletServiceOperationFactoryProtocol
    let networkResolver: WalletNetworkResolverProtocol

    init(networkResolver: WalletNetworkResolverProtocol,
         operationFactory: WalletServiceOperationFactoryProtocol,
         operationQueue: OperationQueue = OperationQueue()) {
        self.networkResolver = networkResolver
        self.operationFactory = operationFactory
        self.operationQueue = operationQueue
    }
}

extension WalletService: WalletServiceProtocol {
    func fetchBalance(for assets: [IRAssetId],
                      runCompletionIn queue: DispatchQueue,
                      completionBlock: @escaping BalanceCompletionBlock) -> Operation {
        let urlTemplate = networkResolver.urlTemplate(for: .balance)

        let operation = operationFactory.fetchBalanceOperation(urlTemplate, assets: assets)
        operation.requestModifier = networkResolver.adapter(for: .balance)

        operation.completionBlock = {
            queue.async {
                completionBlock(operation.result)
            }
        }

        operationQueue.addOperation(operation)

        return operation
    }

    func fetchTransactionHistory(for filter: WalletHistoryRequest,
                                 pagination: OffsetPagination,
                                 runCompletionIn queue: DispatchQueue,
                                 completionBlock: @escaping TransactionHistoryBlock) throws -> Operation {

        let urlTemplate = networkResolver.urlTemplate(for: .history)

        let operation = operationFactory.fetchTransactionHistoryOperation(urlTemplate,
                                                                          filter: filter,
                                                                          pagination: pagination)
        operation.requestModifier = networkResolver.adapter(for: .history)
        operation.networkSession.configuration.urlCache = nil
        operation.networkSession.configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData

        operation.completionBlock = {
            queue.async {
                completionBlock(operation.result)
            }
        }

        operationQueue.addOperation(operation)

        return operation
    }

    func transfer(info: TransferInfo,
                  runCompletionIn queue: DispatchQueue,
                  completionBlock: @escaping BoolResultCompletionBlock) -> Operation {
        let urlTemplate = networkResolver.urlTemplate(for: .transfer)

        let operation = operationFactory.transferOperation(urlTemplate, info: info)
        operation.requestModifier = networkResolver.adapter(for: .transfer)

        operation.completionBlock = {
            queue.async {
                completionBlock(operation.result)
            }
        }

        operationQueue.addOperation(operation)

        return operation
    }

    func search(for searchString: String,
                runCompletionIn queue: DispatchQueue,
                completionBlock: @escaping SearchCompletionBlock) -> Operation {
        let urlTemplate = networkResolver.urlTemplate(for: .search)

        let operation = operationFactory.searchOperation(urlTemplate, searchString: searchString)
        operation.requestModifier = networkResolver.adapter(for: .search)

        operation.completionBlock = {
            queue.async {
                completionBlock(operation.result)
            }
        }

        operationQueue.addOperation(operation)

        return operation
    }
    
    func fetchContacts(runCompletionIn queue: DispatchQueue,
                       completionBlock: @escaping SearchCompletionBlock) -> Operation {
        let requestType = WalletRequestType.contacts
        let urlTemplate = networkResolver.urlTemplate(for: requestType)
        
        let operation = operationFactory.contactsOperation(urlTemplate)
        operation.requestModifier = networkResolver.adapter(for: requestType)
        
        operation.completionBlock = {
            queue.async {
                completionBlock(operation.result)
            }
        }
        
        operationQueue.addOperation(operation)
        
        return operation
    }
    
}
