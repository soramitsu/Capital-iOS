/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood
import IrohaCommunication

protocol DataProviderFactoryProtocol: class {
    func createBalanceDataProvider() throws -> SingleValueProvider<[BalanceData], CDCWSingleValue>
    func createAccountHistoryDataProvider() throws -> SingleValueProvider<AssetTransactionPageData, CDCWSingleValue>
    func createHistoryDataProvider(for asset: IRAssetId) throws
        -> SingleValueProvider<AssetTransactionPageData, CDCWSingleValue>
}

final class DataProviderFactory {
    static let executionQueue: OperationQueue = OperationQueue()
    static let balanceSyncQueue = DispatchQueue(label: "co.jp.soramitsu.wallet.cache.balance.queue")
    static let historySyncQueue = DispatchQueue(label: "co.jp.soramitsu.wallet.cache.history.queue")
    static let assetSyncQueue = DispatchQueue(label: "co.jp.soramitsu.wallet.cache.asset.queue")
    static let contactsSyncQueue = DispatchQueue(label: "co.jp.soramitsu.wallet.cache.contacts.queue")

    static let historyItemsPerPage: Int = 100

    let networkResolver: WalletNetworkResolverProtocol
    let accountSettings: WalletAccountSettingsProtocol
    let cacheFacade: CoreDataCacheFacadeProtocol
    let networkOperationFactory: WalletServiceOperationFactoryProtocol

    init(networkResolver: WalletNetworkResolverProtocol,
         accountSettings: WalletAccountSettingsProtocol,
         cacheFacade: CoreDataCacheFacadeProtocol,
         networkOperationFactory: WalletServiceOperationFactoryProtocol) {
        self.networkResolver = networkResolver
        self.accountSettings = accountSettings
        self.cacheFacade = cacheFacade
        self.networkOperationFactory = networkOperationFactory
    }

    var balanceCacheIdentifier: String {
        return "\(accountSettings.accountId.identifier())#_balance"
    }

    var historyCacheIdentifier: String {
        return "\(accountSettings.accountId.identifier())#_history"
    }
    
    var contactsCacheIdentifier: String {
        return "\(accountSettings.accountId.identifier())#contacts)"
    }

    func cacheIdentifier(for asset: IRAssetId) -> String {
        return "\(accountSettings.accountId.identifier())#\(asset.identifier())"
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
                let operation = self.networkOperationFactory.fetchTransactionHistoryOperation(urlTemplate,
                                                                                              assets: assets,
                                                                                              pagination: pagination)
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

    func createAccountHistoryDataProvider() throws
        -> SingleValueProvider<AssetTransactionPageData, CDCWSingleValue> {
        let assets = accountSettings.assets.map { $0.identifier }
        return try createDataProvider(for: assets,
                                      targetIdentifier: historyCacheIdentifier,
                                      using: DataProviderFactory.historySyncQueue)
    }

    func createHistoryDataProvider(for asset: IRAssetId) throws
        -> SingleValueProvider<AssetTransactionPageData, CDCWSingleValue> {
        return try createDataProvider(for: [asset],
                                      targetIdentifier: cacheIdentifier(for: asset),
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
}
