/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
@testable import CommonWallet
import RobinHood
import CoreData


final class CoreDataTestCacheFacade: CoreDataCacheFacadeProtocol {
    let databaseService: CoreDataServiceProtocol

    init() {
        let modelName = "CapitalCache"
        let bundle = Bundle(for: CoreDataCacheFacade.self)
        let modelURL = bundle.url(forResource: modelName, withExtension: "momd")

        let configuration = CoreDataServiceConfiguration(modelURL: modelURL!,
                                                         storageType: .inMemory)
        databaseService = CoreDataService(configuration: configuration)
    }

    func createCoreDataCache<T, U>(filter: NSPredicate?) -> CoreDataRepository<T, U>
        where T: Identifiable & Codable, U: NSManagedObject & CoreDataCodable {

            let mapper = AnyCoreDataMapper(CodableCoreDataMapper<T, U>())
            return CoreDataRepository(databaseService: databaseService,
                                      mapper: mapper,
                                      filter: filter)
    }
}
