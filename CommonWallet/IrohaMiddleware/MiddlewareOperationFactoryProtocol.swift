/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication
import RobinHood

public protocol MiddlewareOperationFactoryProtocol: WalletNetworkOperationFactoryProtocol {
    var accountSettings: WalletAccountSettingsProtocol { get }
    var operationSettings: MiddlewareOperationSettingsProtocol { get }
    var networkResolver: MiddlewareNetworkResolverProtocol { get }
    var encoder: JSONEncoder { get }
    var decoder: JSONDecoder { get }
}

private struct Constants {
    static let queryEncoding = CharacterSet.urlQueryAllowed
        .subtracting(CharacterSet(charactersIn: "+"))
}

public extension MiddlewareOperationFactoryProtocol {
    func fetchBalanceOperation(_ assets: [String]) -> BaseOperation<[BalanceData]?> {
        let urlTemplate = networkResolver.urlTemplate(for: .balance)

        let requestFactory = BlockNetworkRequestFactory {
            guard let serviceUrl = URL(string: urlTemplate) else {
                throw NetworkBaseError.invalidUrl
            }

            let accountId = try IRAccountIdFactory.account(withIdentifier: self.accountSettings.accountId)

            let queryRequest = try IRQueryBuilder()
                .withCreatorAccountId(accountId)
                .getAccountAssets(accountId)
                .build()
                .signed(withSignatory: self.operationSettings.signer,
                        signatoryPublicKey: self.operationSettings.publicKey)

            let queryData = try IRSerializationFactory.serializeQueryRequest(queryRequest)

            let queryInfo = BalanceQueryInfo(assets: assets, query: queryData)

            var request = URLRequest(url: serviceUrl)
            request.httpMethod = HttpMethod.post.rawValue
            request.httpBody = try self.encoder.encode(queryInfo)
            request.setValue(HttpContentType.json.rawValue, forHTTPHeaderField: HttpHeaderKey.contentType.rawValue)
            return request
        }

        let resultFactory = AnyNetworkResultFactory<[BalanceData]?> { (data) in
            let resultData = try self.decoder.decode(ResultData<[BalanceData]>.self, from: data)

            guard resultData.status.isSuccess else {
                if let errorFactory = self.networkResolver.errorFactory(for: .balance) {
                    throw errorFactory.createErrorFromStatus(resultData.status.code)
                } else {
                    throw ResultStatusError(statusData: resultData.status)
                }
            }

            guard let balances = resultData.result else {
                throw NetworkBaseError.unexpectedResponseObject
            }

            return balances
        }

        let operation = NetworkOperation(requestFactory: requestFactory, resultFactory: resultFactory)
        operation.requestModifier = networkResolver.adapter(for: .balance)

        return operation
    }

    func fetchTransactionHistoryOperation(_ filter: WalletHistoryRequest,
                                          pagination: OffsetPagination) -> BaseOperation<AssetTransactionPageData?> {
        let urlTemplate = networkResolver.urlTemplate(for: .history)

        let requestFactory = BlockNetworkRequestFactory {
            let serviceUrl = try EndpointBuilder(urlTemplate: urlTemplate).buildURL(with: pagination)

            var request = URLRequest(url: serviceUrl)
            request.httpMethod = HttpMethod.post.rawValue
            request.httpBody = try self.encoder.encode(filter)
            request.setValue(HttpContentType.json.rawValue, forHTTPHeaderField: HttpHeaderKey.contentType.rawValue)
            return request
        }

        let resultFactory = AnyNetworkResultFactory<AssetTransactionPageData?> { (data) in
            let resultData = try self.decoder.decode(MultifieldResultData<AssetTransactionPageData>.self,
                                                     from: data)

            guard resultData.status.isSuccess else {
                if let errorFactory = self.networkResolver.errorFactory(for: .history) {
                    throw errorFactory.createErrorFromStatus(resultData.status.code)
                } else {
                    throw ResultStatusError(statusData: resultData.status)
                }
            }

            return resultData.result
        }

        let operation = NetworkOperation(requestFactory: requestFactory, resultFactory: resultFactory)
        operation.requestModifier = networkResolver.adapter(for: .history)

        return operation
    }

    func transferMetadataOperation(_ info: TransferMetadataInfo) -> BaseOperation<TransferMetaData?> {
        let urlTemplate = networkResolver.urlTemplate(for: .transferMetadata)

        let requestFactory = BlockNetworkRequestFactory {
            let serviceUrl = try EndpointBuilder(urlTemplate: urlTemplate)
                .withUrlEncoding(allowedCharset: Constants.queryEncoding)
                .buildParameterURL(info.assetId)

            var request = URLRequest(url: serviceUrl)
            request.httpMethod = HttpMethod.get.rawValue
            return request
        }

        let resultFactory = AnyNetworkResultFactory<TransferMetaData?> { data in
            let resultData = try self.decoder.decode(MultifieldResultData<TransferMetaData>.self, from: data)

            guard resultData.status.isSuccess else {
                if let errorFactory = self.networkResolver.errorFactory(for: .transferMetadata) {
                    throw errorFactory.createErrorFromStatus(resultData.status.code)
                } else {
                    throw ResultStatusError(statusData: resultData.status)
                }
            }

            return resultData.result
        }

        let operation = NetworkOperation(requestFactory: requestFactory, resultFactory: resultFactory)
        operation.requestModifier = networkResolver.adapter(for: .transferMetadata)

        return operation
    }

    func transferOperation(_ info: TransferInfo) -> BaseOperation<Void> {
        let urlTemplate = networkResolver.urlTemplate(for: .transfer)

        let requestFactory = BlockNetworkRequestFactory {
            guard let serviceUrl = URL(string: urlTemplate) else {
                throw NetworkBaseError.invalidUrl
            }

            let amount = try IRAmountFactory.transferAmount(from: info.amount.stringValue)

            let creatorAccountId = try IRAccountIdFactory.account(withIdentifier: self.accountSettings.accountId)
            let sourceAccountId = try IRAccountIdFactory.account(withIdentifier: info.source)
            let destinationAccountId = try IRAccountIdFactory.account(withIdentifier: info.destination)
            let assetId = try IRAssetIdFactory.asset(withIdentifier: info.asset)

            var transactionBuilder = IRTransactionBuilder(creatorAccountId: creatorAccountId)
                .transferAsset(sourceAccountId,
                               destinationAccount: destinationAccountId,
                               assetId: assetId,
                               description: info.details,
                               amount: amount)

            if let fee = info.fee, let feeAccountIdString = info.feeAccountId {
                let feeDescription = "transfer fee"
                let feeAmount = try IRAmountFactory.transferAmount(from: fee.stringValue)
                let feeAccountId = try IRAccountIdFactory.account(withIdentifier: feeAccountIdString)

                transactionBuilder = transactionBuilder.transferAsset(sourceAccountId,
                                                                      destinationAccount: feeAccountId,
                                                                      assetId: assetId,
                                                                      description: feeDescription,
                                                                      amount: feeAmount)
            }

            let transaction = try transactionBuilder.withQuorum(self.operationSettings.transactionQuorum)
                .build()
                .signed(withSignatories: [self.operationSettings.signer],
                        signatoryPublicKeys: [self.operationSettings.publicKey])

            let transactionData = try IRSerializationFactory.serializeTransaction(transaction)
            let transactionInfo = TransactionInfo(transaction: transactionData)

            var request = URLRequest(url: serviceUrl)
            request.httpMethod = HttpMethod.post.rawValue
            request.httpBody = try self.encoder.encode(transactionInfo)
            request.setValue(HttpContentType.json.rawValue, forHTTPHeaderField: HttpHeaderKey.contentType.rawValue)
            return request
        }

        let resultFactory = AnyNetworkResultFactory<Void> { (data) in
            let resultData = try self.decoder.decode(ResultData<Bool>.self, from: data)

            guard resultData.status.isSuccess else {
                if let errorFactory = self.networkResolver.errorFactory(for: .transfer) {
                    throw errorFactory.createErrorFromStatus(resultData.status.code)
                } else {
                    throw ResultStatusError(statusData: resultData.status)
                }
            }
        }

        let operation = NetworkOperation(requestFactory: requestFactory, resultFactory: resultFactory)
        operation.requestModifier = networkResolver.adapter(for: .transfer)

        return operation
    }

    func searchOperation(_ searchString: String) -> BaseOperation<[SearchData]?> {
        let urlTemplate = networkResolver.urlTemplate(for: .search)

        let requestFactory = BlockNetworkRequestFactory {
            guard let encodedString = searchString
                .addingPercentEncoding(withAllowedCharacters: Constants.queryEncoding) else {
                    throw NetworkResponseError.invalidParameters
            }

            let serviceUrl = try EndpointBuilder(urlTemplate: urlTemplate).buildParameterURL(encodedString)

            var request = URLRequest(url: serviceUrl)
            request.httpMethod = HttpMethod.get.rawValue
            return request
        }

        let resultFactory = AnyNetworkResultFactory<[SearchData]?> { (data) in
            let resultData = try self.decoder.decode(ResultData<[SearchData]>.self, from: data)

            guard resultData.status.isSuccess else {
                if let errorFactory = self.networkResolver.errorFactory(for: .search) {
                    throw errorFactory.createErrorFromStatus(resultData.status.code)
                } else {
                    throw ResultStatusError(statusData: resultData.status)
                }
            }

            guard let searchData = resultData.result else {
                throw NetworkBaseError.unexpectedResponseObject
            }

            return searchData
        }

        let operation = NetworkOperation(requestFactory: requestFactory, resultFactory: resultFactory)
        operation.requestModifier = networkResolver.adapter(for: .search)

        return operation
    }

    func contactsOperation() -> BaseOperation<[SearchData]?> {
        let urlTemplate = networkResolver.urlTemplate(for: .contacts)

        let requestFactory = BlockNetworkRequestFactory {
            guard let serviceUrl = URL(string: urlTemplate) else {
                throw NetworkBaseError.invalidUrl
            }

            var request = URLRequest(url: serviceUrl)
            request.httpMethod = HttpMethod.get.rawValue
            return request
        }

        let resultFactory = AnyNetworkResultFactory<[SearchData]?> { (data) in
            let resultData = try self.decoder.decode(ResultData<[SearchData]>.self, from: data)

            guard resultData.status.isSuccess else {
                if let errorFactory = self.networkResolver.errorFactory(for: .contacts) {
                    throw errorFactory.createErrorFromStatus(resultData.status.code)
                } else {
                    throw ResultStatusError(statusData: resultData.status)
                }
            }

            guard let searchData = resultData.result else {
                throw NetworkBaseError.unexpectedResponseObject
            }

            return searchData
        }

        let operation = NetworkOperation(requestFactory: requestFactory, resultFactory: resultFactory)
        operation.requestModifier = networkResolver.adapter(for: .contacts)

        return operation
    }

    func withdrawalMetadataOperation(_ info: WithdrawMetadataInfo) -> BaseOperation<WithdrawMetaData?> {
        let urlTemplate = networkResolver.urlTemplate(for: .withdrawalMetadata)

        let requestFactory = BlockNetworkRequestFactory {
            let serviceUrl = try EndpointBuilder(urlTemplate: urlTemplate)
                .withUrlEncoding(allowedCharset: Constants.queryEncoding)
                .buildURL(with: info)

            var request = URLRequest(url: serviceUrl)
            request.httpMethod = HttpMethod.get.rawValue
            return request
        }

        let resultFactory = AnyNetworkResultFactory<WithdrawMetaData?> { data in
            let resultData = try self.decoder.decode(MultifieldResultData<WithdrawMetaData>.self, from: data)

            guard resultData.status.isSuccess else {
                if let errorFactory = self.networkResolver.errorFactory(for: .withdrawalMetadata) {
                    throw errorFactory.createErrorFromStatus(resultData.status.code)
                } else {
                    throw ResultStatusError(statusData: resultData.status)
                }
            }

            return resultData.result
        }

        let operation = NetworkOperation(requestFactory: requestFactory, resultFactory: resultFactory)
        operation.requestModifier = networkResolver.adapter(for: .withdrawalMetadata)

        return operation
    }

    func withdrawOperation(_ info: WithdrawInfo) -> BaseOperation<Void> {
        let urlTemplate = networkResolver.urlTemplate(for: .withdraw)

        let requestFactory = BlockNetworkRequestFactory {
            guard let serviceUrl = URL(string: urlTemplate) else {
                throw NetworkBaseError.invalidUrl
            }

            let amount = try IRAmountFactory.transferAmount(from: info.amount.stringValue)

            let accountId = try IRAccountIdFactory.account(withIdentifier: self.accountSettings.accountId)
            let destinationAccountId = try IRAccountIdFactory.account(withIdentifier: info.destinationAccountId)
            let assetId = try IRAssetIdFactory.asset(withIdentifier: info.assetId)

            var transactionBuilder = IRTransactionBuilder(creatorAccountId: accountId)
                .transferAsset(accountId,
                               destinationAccount: destinationAccountId,
                               assetId: assetId,
                               description: info.details,
                               amount: amount)

            if let fee = info.fee, let feeAccountIdString = info.feeAccountId {
                let feeDescription = "withdrawal fee"
                let feeAmount = try IRAmountFactory.transferAmount(from: fee.stringValue)
                let feeAccountId = try IRAccountIdFactory.account(withIdentifier: feeAccountIdString)

                transactionBuilder = transactionBuilder.transferAsset(accountId,
                                                                      destinationAccount: feeAccountId,
                                                                      assetId: assetId,
                                                                      description: feeDescription,
                                                                      amount: feeAmount)
            }

            let transaction = try transactionBuilder
                .withQuorum(self.operationSettings.transactionQuorum)
                .build()
                .signed(withSignatories: [self.operationSettings.signer],
                        signatoryPublicKeys: [self.operationSettings.publicKey])

            let transactionData = try IRSerializationFactory.serializeTransaction(transaction)
            let transactionInfo = TransactionInfo(transaction: transactionData)

            var request = URLRequest(url: serviceUrl)
            request.httpMethod = HttpMethod.post.rawValue
            request.httpBody = try self.encoder.encode(transactionInfo)
            request.setValue(HttpContentType.json.rawValue,
                             forHTTPHeaderField: HttpHeaderKey.contentType.rawValue)
            return request
        }

        let resultFactory = AnyNetworkResultFactory<Void> { data in
            let resultData = try self.decoder.decode(ResultData<Bool>.self, from: data)

            guard resultData.status.isSuccess else {
                if let errorFactory = self.networkResolver.errorFactory(for: .withdraw) {
                    throw errorFactory.createErrorFromStatus(resultData.status.code)
                } else {
                    throw ResultStatusError(statusData: resultData.status)
                }
            }
        }

        let operation = NetworkOperation(requestFactory: requestFactory, resultFactory: resultFactory)
        operation.requestModifier = networkResolver.adapter(for: .withdraw)

        return operation
    }

}
