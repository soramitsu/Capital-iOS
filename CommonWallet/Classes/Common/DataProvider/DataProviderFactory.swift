/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood
import IrohaCommunication

protocol DataProviderFactoryProtocol: class {
    func createBalanceDataProvider() throws -> SingleValueProvider<[BalanceData]>
    func createHistoryDataProvider(for assets: [IRAssetId]) throws
        -> SingleValueProvider<AssetTransactionPageData>
    func createContactsDataProvider() throws -> SingleValueProvider<[SearchData]>
    func createWithdrawMetadataProvider(for assetId: IRAssetId, option: String)
        throws -> SingleValueProvider<WithdrawMetaData>
    func createTransferMetadataProvider(for assetId: IRAssetId, receiver: IRAccountId)
        throws -> SingleValueProvider<TransferMetaData>
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

    let accountSettings: WalletAccountSettingsProtocol
    let cacheFacade: CoreDataCacheFacadeProtocol
    let networkOperationFactory: WalletNetworkOperationFactoryProtocol

    init(accountSettings: WalletAccountSettingsProtocol,
         cacheFacade: CoreDataCacheFacadeProtocol,
         networkOperationFactory: WalletNetworkOperationFactoryProtocol) {
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
        -> CoreDataRepository<SingleValueProviderObject, CDCWSingleValue> {
            return cacheFacade.createCoreDataCache(filter: nil)
    }

    private func createDataProvider(for assets: [IRAssetId],
                                    targetIdentifier: String,
                                    using syncQueue: DispatchQueue) throws
        -> SingleValueProvider<AssetTransactionPageData> {
            let pagination = OffsetPagination(offset: 0, count: DataProviderFactory.historyItemsPerPage)

            let source: AnySingleValueProviderSource<AssetTransactionPageData> =
                AnySingleValueProviderSource {
                    var filter = WalletHistoryRequest()
                    filter.assets = assets
                    let operation = self.networkOperationFactory
                        .fetchTransactionHistoryOperation(filter, pagination: pagination)
                    return operation
            }

            let cache = createSingleValueCache()

            let updateTrigger = DataProviderEventTrigger.onAddObserver

            return SingleValueProvider(targetIdentifier: targetIdentifier,
                                       source: source,
                                       repository: AnyDataProviderRepository(cache),
                                       updateTrigger: updateTrigger,
                                       executionQueue: DataProviderFactory.executionQueue,
                                       serialSyncQueue: DataProviderFactory.balanceSyncQueue)
    }
}

extension DataProviderFactory: DataProviderFactoryProtocol {
    func createBalanceDataProvider() throws -> SingleValueProvider<[BalanceData]> {
        let source: AnySingleValueProviderSource<[BalanceData]> = AnySingleValueProviderSource {
            let assets = self.accountSettings.assets.map { $0.identifier }
            let operation = self.networkOperationFactory.fetchBalanceOperation(assets)
            return operation
        }

        let cache = createSingleValueCache()

        let updateTrigger = DataProviderEventTrigger.onAddObserver

        return SingleValueProvider(targetIdentifier: balanceCacheIdentifier,
                                   source: source,
                                   repository: AnyDataProviderRepository(cache),
                                   updateTrigger: updateTrigger,
                                   executionQueue: DataProviderFactory.executionQueue,
                                   serialSyncQueue: DataProviderFactory.balanceSyncQueue)
    }

    func createHistoryDataProvider(for assets: [IRAssetId]) throws -> SingleValueProvider<AssetTransactionPageData> {
        return try createDataProvider(for: assets,
                                      targetIdentifier: cacheIdentifier(for: assets),
                                      using: DataProviderFactory.assetSyncQueue)
    }
    
    func createContactsDataProvider() throws -> SingleValueProvider<[SearchData]> {
        let source: AnySingleValueProviderSource<[SearchData]> = AnySingleValueProviderSource {
            let operation = self.networkOperationFactory.contactsOperation()
            return operation
        }
        
        let cache = createSingleValueCache()
        
        let updateTrigger = DataProviderEventTrigger.onAddObserver
        
        return SingleValueProvider(targetIdentifier: contactsCacheIdentifier,
                                   source: source,
                                   repository: AnyDataProviderRepository(cache),
                                   updateTrigger: updateTrigger,
                                   executionQueue: DataProviderFactory.executionQueue,
                                   serialSyncQueue: DataProviderFactory.contactsSyncQueue)
    }

    func createWithdrawMetadataProvider(for assetId: IRAssetId, option: String)
        throws -> SingleValueProvider<WithdrawMetaData> {
        let info = WithdrawMetadataInfo(assetId: assetId.identifier(), option: option)
        let source: AnySingleValueProviderSource<WithdrawMetaData> = AnySingleValueProviderSource {
            let operation = self.networkOperationFactory.withdrawalMetadataOperation(info)
            return operation
        }

        let cache = createSingleValueCache()

        let updateTrigger = DataProviderEventTrigger.onAddObserver

        let identifier = withdrawMetadataIdentifier(for: assetId, optionId: option)
        return SingleValueProvider(targetIdentifier: identifier,
                                   source: source,
                                   repository: AnyDataProviderRepository(cache),
                                   updateTrigger: updateTrigger,
                                   executionQueue: DataProviderFactory.executionQueue,
                                   serialSyncQueue: DataProviderFactory.withdrawalMetadataQueue)
    }

    func createTransferMetadataProvider(for assetId: IRAssetId, receiver: IRAccountId)
        throws -> SingleValueProvider<TransferMetaData> {
        let info = TransferMetadataInfo(assetId: assetId,
                                        sender: accountSettings.accountId,
                                        receiver: receiver)
        let source: AnySingleValueProviderSource<TransferMetaData> = AnySingleValueProviderSource {
            let operation = self.networkOperationFactory.transferMetadataOperation(info)
            return operation
        }

        let cache = createSingleValueCache()

        let updateTrigger = DataProviderEventTrigger.onAddObserver

        let identifier = transferMetadataIdentifier(for: assetId)
        return SingleValueProvider(targetIdentifier: identifier,
                                   source: source,
                                   repository: AnyDataProviderRepository(cache),
                                   updateTrigger: updateTrigger,
                                   executionQueue: DataProviderFactory.executionQueue,
                                   serialSyncQueue: DataProviderFactory.transferMetadataQueue)
    }

}
