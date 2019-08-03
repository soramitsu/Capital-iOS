/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication
import RobinHood

final class WalletServiceOperationFactory {
    private struct Constants {
        static let queryEncoding = CharacterSet.urlQueryAllowed
            .subtracting(CharacterSet(charactersIn: "+"))
    }

    let accountSettings: WalletAccountSettingsProtocol

    private lazy var jsonDecoder = JSONDecoder()
    private lazy var jsonEncoder = JSONEncoder()

    init(accountSettings: WalletAccountSettingsProtocol) {
        self.accountSettings = accountSettings
    }
}

extension WalletServiceOperationFactory: WalletServiceOperationFactoryProtocol {
    func fetchBalanceOperation(_ urlTemplate: String, assets: [IRAssetId]) -> NetworkOperation<[BalanceData]> {
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
            request.httpBody = try self.jsonEncoder.encode(queryInfo)
            request.setValue(HttpContentType.json.rawValue, forHTTPHeaderField: HttpHeaderKey.contentType.rawValue)
            return request
        }

        let resultFactory = AnyNetworkResultFactory<[BalanceData]> { (data) in
            let resultData = try self.jsonDecoder.decode(ResultData<[BalanceData]>.self, from: data)

            guard resultData.status.isSuccess else {
                throw ResultStatusError(statusData: resultData.status)
            }

            guard let balances = resultData.result else {
                throw NetworkBaseError.unexpectedResponseObject
            }

            return balances
        }

        return NetworkOperation(requestFactory: requestFactory,
                                resultFactory: resultFactory)
    }

    func fetchTransactionHistoryOperation(_ urlTemplate: String,
                                          filter: WalletHistoryRequest,
                                          pagination: OffsetPagination) -> NetworkOperation<AssetTransactionPageData> {

        let requestFactory = BlockNetworkRequestFactory {
            let serviceUrl = try EndpointBuilder(urlTemplate: urlTemplate).buildURL(with: pagination)

            var request = URLRequest(url: serviceUrl)
            request.httpMethod = HttpMethod.post.rawValue
            request.httpBody = try self.jsonEncoder.encode(filter)
            return request
        }

        let resultFactory = AnyNetworkResultFactory<AssetTransactionPageData> { (data) in
            let resultData = try self.jsonDecoder.decode(MultifieldResultData<AssetTransactionPageData>.self,
                                                         from: data)

            guard resultData.status.isSuccess else {
                throw ResultStatusError(statusData: resultData.status)
            }

            return resultData.result
        }

        return NetworkOperation(requestFactory: requestFactory,
                                resultFactory: resultFactory)
    }

    func transferOperation(_ urlTemplate: String, info: TransferInfo) -> NetworkOperation<Bool> {
        let requestFactory = BlockNetworkRequestFactory {
            guard let serviceUrl = URL(string: urlTemplate) else {
                throw NetworkBaseError.invalidUrl
            }

            let transaction = try IRTransactionBuilder(creatorAccountId: self.accountSettings.accountId)
                .transferAsset(info.source,
                               destinationAccount: info.destination,
                               assetId: info.asset,
                               description: info.details,
                               amount: info.amount)
                .withQuorum(self.accountSettings.transactionQuorum)
                .build()
                .signed(withSignatories: [self.accountSettings.signer],
                        signatoryPublicKeys: [self.accountSettings.publicKey])

            let transactionData = try IRSerializationFactory.serializeTransaction(transaction)
            let transactionInfo = TransactionInfo(transaction: transactionData)

            var request = URLRequest(url: serviceUrl)
            request.httpMethod = HttpMethod.post.rawValue
            request.httpBody = try self.jsonEncoder.encode(transactionInfo)
            request.setValue(HttpContentType.json.rawValue, forHTTPHeaderField: HttpHeaderKey.contentType.rawValue)
            return request
        }

        let resultFactory = AnyNetworkResultFactory<Bool> { (data) in
            let resultData = try self.jsonDecoder.decode(ResultData<Bool>.self, from: data)

            guard resultData.status.isSuccess else {
                throw ResultStatusError(statusData: resultData.status)
            }

            return true
        }

        return NetworkOperation(requestFactory: requestFactory,
                                resultFactory: resultFactory)
    }

    func searchOperation(_ urlTemplate: String, searchString: String) -> NetworkOperation<[SearchData]> {
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

        let resultFactory = AnyNetworkResultFactory<[SearchData]> { (data) in
            let resultData = try self.jsonDecoder.decode(ResultData<[SearchData]>.self, from: data)

            guard resultData.status.isSuccess else {
                throw ResultStatusError(statusData: resultData.status)
            }

            guard let searchData = resultData.result else {
                throw NetworkBaseError.unexpectedResponseObject
            }

            return searchData
        }

        return NetworkOperation(requestFactory: requestFactory,
                                resultFactory: resultFactory)
    }
    
    func contactsOperation(_ urlTemplate: String) -> NetworkOperation<[SearchData]> {
        let requestFactory = BlockNetworkRequestFactory {
            guard let serviceUrl = URL(string: urlTemplate) else {
                throw NetworkBaseError.invalidUrl
            }
            
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = HttpMethod.get.rawValue
            return request
        }
        
        let resultFactory = AnyNetworkResultFactory<[SearchData]> { (data) in
            let resultData = try self.jsonDecoder.decode(ResultData<[SearchData]>.self, from: data)
            
            guard resultData.status.isSuccess else {
                throw ResultStatusError(statusData: resultData.status)
            }
            
            guard let searchData = resultData.result else {
                throw NetworkBaseError.unexpectedResponseObject
            }
            
            return searchData
        }
        
        return NetworkOperation(requestFactory: requestFactory,
                                resultFactory: resultFactory)
    }

    func withdrawalMetadataOperation(_ urlTemplate: String,
                                     info: WithdrawMetadataInfo) -> NetworkOperation<WithdrawMetaData> {
        let requestFactory = BlockNetworkRequestFactory {
            let serviceUrl = try EndpointBuilder(urlTemplate: urlTemplate)
                .withUrlEncoding(allowedCharset: Constants.queryEncoding)
                .buildURL(with: info)

            var request = URLRequest(url: serviceUrl)
            request.httpMethod = HttpMethod.get.rawValue
            return request
        }

        let resultFactory = AnyNetworkResultFactory<WithdrawMetaData> { data in
            let resultData = try self.jsonDecoder.decode(MultifieldResultData<WithdrawMetaData>.self, from: data)

            guard resultData.status.isSuccess else {
                throw ResultStatusError(statusData: resultData.status)
            }

            return resultData.result
        }

        return NetworkOperation(requestFactory: requestFactory, resultFactory: resultFactory)
    }

    func withdrawOperation(_ urlTemplate: String, info: WithdrawInfo) -> NetworkOperation<Void> {
        let requestFactory = BlockNetworkRequestFactory {
            guard let serviceUrl = URL(string: urlTemplate) else {
                throw NetworkBaseError.invalidUrl
            }

            var transactionBuilder = IRTransactionBuilder(creatorAccountId: self.accountSettings.accountId)
                .transferAsset(self.accountSettings.accountId,
                               destinationAccount: info.destinationAccountId,
                               assetId: info.assetId,
                               description: info.details,
                               amount: info.amount)

            if let fee = info.fee, let feeAccountId = info.feeAccountId {
                let feeDescription = "withdrawal fee"
                transactionBuilder = transactionBuilder.transferAsset(self.accountSettings.accountId,
                                                                      destinationAccount: feeAccountId,
                                                                      assetId: info.assetId,
                                                                      description: feeDescription,
                                                                      amount: fee)
            }

            let transaction = try transactionBuilder.build()

            let transactionData = try IRSerializationFactory.serializeTransaction(transaction)
            let transactionInfo = TransactionInfo(transaction: transactionData)

            var request = URLRequest(url: serviceUrl)
            request.httpMethod = HttpMethod.post.rawValue
            request.httpBody = try self.jsonEncoder.encode(transactionInfo)
            request.setValue(HttpContentType.json.rawValue,
                             forHTTPHeaderField: HttpHeaderKey.contentType.rawValue)
            return request
        }

        let resultFactory = AnyNetworkResultFactory<Void> { data in
            let resultData = try self.jsonDecoder.decode(ResultData<Bool>.self, from: data)

            guard resultData.status.isSuccess else {
                throw ResultStatusError(statusData: resultData.status)
            }
        }

        return NetworkOperation(requestFactory: requestFactory,
                                resultFactory: resultFactory)
    }
}
