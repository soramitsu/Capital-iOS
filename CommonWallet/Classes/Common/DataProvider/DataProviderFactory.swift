/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood
import IrohaCommunication

protocol DataProviderFactoryProtocol: class {
    func createBalanceDataProvider() throws -> SingleValueProvider<[BalanceData], CDCWSingleValue>
    func createHistoryDataProvider(for assets: [IRAssetId]) throws
        -> SingleValueProvider<AssetTransactionPageData, CDCWSingleValue>
    func createContactsDataProvider() throws -> SingleValueProvider<[SearchData], CDCWSingleValue>
    func createWithdrawMetadataProvider(for assetId: IRAssetId, option: String)
        throws -> SingleValueProvider<WithdrawMetaData, CDCWSingleValue>
    func createTransferMetadataProvider(for assetId: IRAssetId)
        throws -> SingleValueProvider<TransferMetaData, CDCWSingleValue>
}

final class DataProviderFactory {
    static let executionQueue: OperationQueue = OperationQueue()
    static let balanceSyncQueue = DispatchQueue(label: "co.jp.soramitsu.wallet.cache.balance.queue")
    static let historySyncQueue = DispatchQueue(label: "co.jp.soramitsu.wallet.cache.history.queue")
    static let assetSyncQueue = DispatchQueue(label: "co.jp.soramitsu.wallet.cache.asset.queue")
    static let contactsSyncQueue = DispatchQueue(label: "co.jp.soramitsu.wallet.cache.contacts.queue")
    static let withdrawalMetadataQueue = DispatchQueue(label: "co.jp.soramitsu.wallet.cache.withdraw.metadata.queue")
    static let transferMetadataQueue = DispatchQueue(label: "co.jp.soramitsu.wallet.cache.transfer.metadata.queue")

    static let historyItemsPerPage: Int = 100

    let networkResolver: WalletNetworkResolverProtocol
    let accountSettings: WalletAccountSettingsProtocol
    let cacheFacade: CoreDataCacheFacadeProtocol
    let networkOperationFactory: WalletNetworkOperationFactoryProtocol

    init(networkResolver: WalletNetworkResolverProtocol,
         accountSettings: WalletAccountSettingsProtocol,
         cacheFacade: CoreDataCacheFacadeProtocol,
         networkOperationFactory: WalletNetworkOperationFactoryProtocol) {
        self.networkResolver = networkResolver
        self.accountSettings = accountSettings
        self.cacheFacade = cacheFacade
        self.networkOperationFactory = networkOperationFactory
    }

    var balanceCacheIdentifier: String {
        return "\(accountSettings.accountId.identifier())#_balance"
    }
    
    var contactsCacheIdentifier: String {
        return "\(accountSettings.accountId.identifier())#contacts)"
    }

    func cacheIdentifier(for assets: [IRAssetId]) -> String {
        let cacheIdentifier = assets.map({ $0.identifier() }).sorted().joined()
        return "\(accountSettings.accountId.identifier())#\(cacheIdentifier.hash)"
    }

    func withdrawMetadataIdentifier(for assetId: IRAssetId, optionId: String) -> String {
        return "\(assetId.identifier())\(optionId)#withdraw-metadata"
    }

    func transferMetadataIdentifier(for assetId: IRAssetId) -> String {
        return "\(assetId.identifier())#transfer-metadata"
    }

    private func createSingleValueCache()
        -> CoreDataCache<SingleValueProviderObject, CDCWSingleValue> {
            return cacheFacade.createCoreDataCache(domain: accountSettings.accountId.domain.identifier)
    }

    private func createDataProvider(for assets: [IRAssetId],
                                    targetIdentifier: String,
                                    using syncQueue: DispatchQueue) throws
        -> SingleValueProvider<AssetTransactionPageData, CDCWSingleValue> {
            let pagination = OffsetPagination(offset: 0, count: DataProviderFactory.historyItemsPerPage)

            let source: AnySingleValueProviderSource<AssetTransactionPageData> =
                AnySingleValueProviderSource(base: self) {
                    let urlTemplate = self.networkResolver.urlTemplate(for: .history)
                    var filter = WalletHistoryRequest()
                    filter.assets = assets
                    let operation = self.networkOperationFactory
                        .fetchTransactionHistoryOperation(urlTemplate, filter: filter, pagination: pagination)
                    operation.requestModifier = self.networkResolver.adapter(for: .history)
                    return operation
            }

            let cache = createSingleValueCache()

            let updateTrigger = DataProviderEventTrigger.onAddObserver

            return SingleValueProvider(targetIdentifier: targetIdentifier,
                                       source: source,
                                       cache: cache,
                                       updateTrigger: updateTrigger,
                                       executionQueue: DataProviderFactory.executionQueue,
                                       serialCacheQueue: DataProviderFactory.balanceSyncQueue)
    }
}

extension DataProviderFactory: DataProviderFactoryProtocol {
    func createBalanceDataProvider() throws -> SingleValueProvider<[BalanceData], CDCWSingleValue> {
        let source: AnySingleValueProviderSource<[BalanceData]> = AnySingleValueProviderSource(base: self) {
            let urlTemplate = self.networkResolver.urlTemplate(for: .balance)
            let assets = self.accountSettings.assets.map { $0.identifier }
            let operation = self.networkOperationFactory.fetchBalanceOperation(urlTemplate,
                                                                               assets: assets)
            operation.requestModifier = self.networkResolver.adapter(for: .balance)
            return operation
        }

        let cache = createSingleValueCache()

        let updateTrigger = DataProviderEventTrigger.onAddObserver

        return SingleValueProvider(targetIdentifier: balanceCacheIdentifier,
                                   source: source,
                                   cache: cache,
                                   updateTrigger: updateTrigger,
                                   executionQueue: DataProviderFactory.executionQueue,
                                   serialCacheQueue: DataProviderFactory.balanceSyncQueue)
    }

    func createHistoryDataProvider(for assets: [IRAssetId]) throws
        -> SingleValueProvider<AssetTransactionPageData, CDCWSingleValue> {
        return try createDataProvider(for: assets,
                                      targetIdentifier: cacheIdentifier(for: assets),
                                      using: DataProviderFactory.assetSyncQueue)
    }
    
    func createContactsDataProvider() throws -> SingleValueProvider<[SearchData], CDCWSingleValue> {
        let source: AnySingleValueProviderSource<[SearchData]> = AnySingleValueProviderSource(base: self) {
            let requestType = WalletRequestType.contacts
            let urlTemplate = self.networkResolver.urlTemplate(for: requestType)
            let operation = self.networkOperationFactory.contactsOperation(urlTemplate)
            operation.requestModifier = self.networkResolver.adapter(for: requestType)
            return operation
        }
        
        let cache = createSingleValueCache()
        
        let updateTrigger = DataProviderEventTrigger.onAddObserver
        
        return SingleValueProvider(targetIdentifier: contactsCacheIdentifier,
                                   source: source,
                                   cache: cache,
                                   updateTrigger: updateTrigger,
                                   executionQueue: DataProviderFactory.executionQueue,
                                   serialCacheQueue: DataProviderFactory.contactsSyncQueue)
    }

    func createWithdrawMetadataProvider(for assetId: IRAssetId, option: String)
        throws -> SingleValueProvider<WithdrawMetaData, CDCWSingleValue> {
        let info = WithdrawMetadataInfo(assetId: assetId.identifier(), option: option)
        let source: AnySingleValueProviderSource<WithdrawMetaData> = AnySingleValueProviderSource(base: self) {
            let requestType = WalletRequestType.withdrawalMetadata
            let urlTemplate = self.networkResolver.urlTemplate(for: requestType)
            let operation = self.networkOperationFactory.withdrawalMetadataOperation(urlTemplate, info: info)
            operation.requestModifier = self.networkResolver.adapter(for: requestType)
            return operation
        }

        let cache = createSingleValueCache()

        let updateTrigger = DataProviderEventTrigger.onAddObserver

        let identifier = withdrawMetadataIdentifier(for: assetId, optionId: option)
        return SingleValueProvider(targetIdentifier: identifier,
                                   source: source,
                                   cache: cache,
                                   updateTrigger: updateTrigger,
                                   executionQueue: DataProviderFactory.executionQueue,
                                   serialCacheQueue: DataProviderFactory.withdrawalMetadataQueue)
    }

    func createTransferMetadataProvider(for assetId: IRAssetId)
        throws -> SingleValueProvider<TransferMetaData, CDCWSingleValue> {
        let source: AnySingleValueProviderSource<TransferMetaData> = AnySingleValueProviderSource(base: self) {
            let requestType = WalletRequestType.transferMetadata
            let urlTemplate = self.networkResolver.urlTemplate(for: requestType)
            let operation = self.networkOperationFactory.transferMetadataOperation(urlTemplate, assetId: assetId)
            operation.requestModifier = self.networkResolver.adapter(for: requestType)
            return operation
        }

        let cache = createSingleValueCache()

        let updateTrigger = DataProviderEventTrigger.onAddObserver

        let identifier = transferMetadataIdentifier(for: assetId)
        return SingleValueProvider(targetIdentifier: identifier,
                                   source: source,
                                   cache: cache,
                                   updateTrigger: updateTrigger,
                                   executionQueue: DataProviderFactory.executionQueue,
                                   serialCacheQueue: DataProviderFactory.transferMetadataQueue)
    }

}
