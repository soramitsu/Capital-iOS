/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood

protocol DataProviderFactoryProtocol: class {
    func createBalanceDataProvider() throws -> SingleValueProvider<[BalanceData]>
    func createHistoryDataProvider(for assets: [String]) throws
        -> SingleValueProvider<AssetTransactionPageData>
    func createContactsDataProvider() throws -> SingleValueProvider<[SearchData]>
    func createWithdrawMetadataProvider(for assetId: String, option: String)
        throws -> SingleValueProvider<WithdrawMetaData>
    func createTransferMetadataProvider(for assetId: String, receiver: String)
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
    let identifierFactory: SingleProviderIdentifierFactoryProtocol

    init(accountSettings: WalletAccountSettingsProtocol,
         cacheFacade: CoreDataCacheFacadeProtocol,
         networkOperationFactory: WalletNetworkOperationFactoryProtocol,
         identifierFactory: SingleProviderIdentifierFactoryProtocol) {
        self.accountSettings = accountSettings
        self.cacheFacade = cacheFacade
        self.networkOperationFactory = networkOperationFactory
        self.identifierFactory = identifierFactory
    }

    private func createSingleValueCache()
        -> CoreDataRepository<SingleValueProviderObject, CDCWSingleValue> {
            return cacheFacade.createCoreDataCache(filter: nil)
    }

    private func createDataProvider(for assets: [String],
                                    targetIdentifier: String,
                                    using syncQueue: DispatchQueue) throws
        -> SingleValueProvider<AssetTransactionPageData> {
            let pagination = Pagination(count: DataProviderFactory.historyItemsPerPage)

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

        let targetId = identifierFactory.balanceIdentifierForAccountId(accountSettings.accountId)

        return SingleValueProvider(targetIdentifier: targetId,
                                   source: source,
                                   repository: AnyDataProviderRepository(cache),
                                   updateTrigger: updateTrigger,
                                   executionQueue: DataProviderFactory.executionQueue,
                                   serialSyncQueue: DataProviderFactory.balanceSyncQueue)
    }

    func createHistoryDataProvider(for assets: [String]) throws -> SingleValueProvider<AssetTransactionPageData> {
        let targetId = identifierFactory.historyIdentifierForAccountId(accountSettings.accountId,
                                                                       assets: assets)
        return try createDataProvider(for: assets,
                                      targetIdentifier: targetId,
                                      using: DataProviderFactory.assetSyncQueue)
    }
    
    func createContactsDataProvider() throws -> SingleValueProvider<[SearchData]> {
        let source: AnySingleValueProviderSource<[SearchData]> = AnySingleValueProviderSource {
            let operation = self.networkOperationFactory.contactsOperation()
            return operation
        }
        
        let cache = createSingleValueCache()
        
        let updateTrigger = DataProviderEventTrigger.onAddObserver

        let targetId = identifierFactory.contactsIdentifierForAccountId(accountSettings.accountId)

        return SingleValueProvider(targetIdentifier: targetId,
                                   source: source,
                                   repository: AnyDataProviderRepository(cache),
                                   updateTrigger: updateTrigger,
                                   executionQueue: DataProviderFactory.executionQueue,
                                   serialSyncQueue: DataProviderFactory.contactsSyncQueue)
    }

    func createWithdrawMetadataProvider(for assetId: String, option: String)
        throws -> SingleValueProvider<WithdrawMetaData> {
        let info = WithdrawMetadataInfo(assetId: assetId, option: option)
        let source: AnySingleValueProviderSource<WithdrawMetaData> = AnySingleValueProviderSource {
            let operation = self.networkOperationFactory.withdrawalMetadataOperation(info)
            return operation
        }

        let cache = createSingleValueCache()

        let updateTrigger = DataProviderEventTrigger.onAddObserver

        let targetId = identifierFactory.withdrawMetadataIdentifierForAccountId(accountSettings.accountId,
                                                                                assetId: assetId,
                                                                                optionId: option)
        return SingleValueProvider(targetIdentifier: targetId,
                                   source: source,
                                   repository: AnyDataProviderRepository(cache),
                                   updateTrigger: updateTrigger,
                                   executionQueue: DataProviderFactory.executionQueue,
                                   serialSyncQueue: DataProviderFactory.withdrawalMetadataQueue)
    }

    func createTransferMetadataProvider(for assetId: String, receiver: String)
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

        let targetId = identifierFactory.transferMetadataIdentifierForAccountId(accountSettings.accountId,
                                                                                assetId: assetId,
                                                                                receiverId: receiver)
        return SingleValueProvider(targetIdentifier: targetId,
                                   source: source,
                                   repository: AnyDataProviderRepository(cache),
                                   updateTrigger: updateTrigger,
                                   executionQueue: DataProviderFactory.executionQueue,
                                   serialSyncQueue: DataProviderFactory.transferMetadataQueue)
    }

}
