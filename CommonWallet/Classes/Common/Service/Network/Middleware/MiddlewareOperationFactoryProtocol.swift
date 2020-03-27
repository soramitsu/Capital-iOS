/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication
import RobinHood

public protocol MiddlewareOperationFactoryProtocol: WalletNetworkOperationFactoryProtocol {
    var accountSettings: WalletAccountSettingsProtocol { get }
    var networkResolver: WalletNetworkResolverProtocol { get }
    var encoder: JSONEncoder { get }
    var decoder: JSONDecoder { get }
}

private struct Constants {
    static let queryEncoding = CharacterSet.urlQueryAllowed
        .subtracting(CharacterSet(charactersIn: "+"))
}

public extension MiddlewareOperationFactoryProtocol {
    func fetchBalanceOperation(_ assets: [IRAssetId]) -> BaseOperation<[BalanceData]?> {
        let urlTemplate = networkResolver.urlTemplate(for: .balance)

        let requestFactory = BlockNetworkRequestFactory {
            guard let serviceUrl = URL(string: urlTemplate) else {
                throw NetworkBaseError.invalidUrl
            }

            let queryRequest = try IRQueryBuilder()
                .withCreatorAccountId(self.accountSettings.accountId)
                .getAccountAssets(self.accountSettings.accountId)
                .build()
                .signed(withSignatory: self.accountSettings.signer,
                        signatoryPublicKey: self.accountSettings.publicKey)

            let queryData = try IRSerializationFactory.serializeQueryRequest(queryRequest)

            let assetIds = assets.map { $0.identifier() }

            let queryInfo = BalanceQueryInfo(assets: assetIds, query: queryData)

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
                .buildParameterURL(info.assetId.identifier())

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

            var transactionBuilder = IRTransactionBuilder(creatorAccountId: self.accountSettings.accountId)
                .transferAsset(info.source,
                               destinationAccount: info.destination,
                               assetId: info.asset,
                               description: info.details,
                               amount: amount)

            if let fee = info.fee, let feeAccountId = info.feeAccountId {
                let feeDescription = "transfer fee"
                let feeAmount = try IRAmountFactory.transferAmount(from: fee.stringValue)

                transactionBuilder = transactionBuilder.transferAsset(self.accountSettings.accountId,
                                                                      destinationAccount: feeAccountId,
                                                                      assetId: info.asset,
                                                                      description: feeDescription,
                                                                      amount: feeAmount)
            }

            let transaction = try transactionBuilder.withQuorum(self.accountSettings.transactionQuorum)
                .build()
                .signed(withSignatories: [self.accountSettings.signer],
                        signatoryPublicKeys: [self.accountSettings.publicKey])

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

            var transactionBuilder = IRTransactionBuilder(creatorAccountId: self.accountSettings.accountId)
                .transferAsset(self.accountSettings.accountId,
                               destinationAccount: info.destinationAccountId,
                               assetId: info.assetId,
                               description: info.details,
                               amount: amount)

            if let fee = info.fee, let feeAccountId = info.feeAccountId {
                let feeDescription = "withdrawal fee"
                let feeAmount = try IRAmountFactory.transferAmount(from: fee.stringValue)

                transactionBuilder = transactionBuilder.transferAsset(self.accountSettings.accountId,
                                                                      destinationAccount: feeAccountId,
                                                                      assetId: info.assetId,
                                                                      description: feeDescription,
                                                                      amount: feeAmount)
            }

            let transaction = try transactionBuilder
                .withQuorum(self.accountSettings.transactionQuorum)
                .build()
                .signed(withSignatories: [self.accountSettings.signer],
                        signatoryPublicKeys: [self.accountSettings.publicKey])

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
