import Foundation
import CoreData
import RobinHood

protocol CoreDataCacheFacadeProtocol: class {
    var databaseService: CoreDataServiceProtocol { get }

    func createCoreDataCache<T, U>(domain: String) -> CoreDataCache<T, U>
        where T: Identifiable & Codable, U: NSManagedObject & CoreDataCodable
}

final class CoreDataCacheFacade: CoreDataCacheFacadeProtocol {
    static let shared = CoreDataCacheFacade()

    let databaseService: CoreDataServiceProtocol

    private init() {
        let modelName = "CapitalCache"
        let bundle = Bundle(for: type(of: self))
        let modelURL = bundle.url(forResource: modelName, withExtension: "momd")
        let baseURL = FileManager.default.urls(for: .cachesDirectory,
                                               in: .userDomainMask).first?.appendingPathComponent(modelName)

        let persistentSettings = CoreDataPersistentSettings(databaseDirectory: baseURL!,
                                                            databaseName: modelName,
                                                            incompatibleModelStrategy: .removeStore)

        let configuration = CoreDataServiceConfiguration(modelURL: modelURL!,
                                                         storageType: .persistent(settings: persistentSettings))
        databaseService = CoreDataService(configuration: configuration)
    }

    func createCoreDataCache<T, U>(domain: String) -> CoreDataCache<T, U>
        where T: Identifiable & Codable, U: NSManagedObject & CoreDataCodable {

            let mapper = AnyCoreDataMapper(CodableCoreDataMapper<T, U>())
            return CoreDataCache(databaseService: databaseService,
                                 mapper: mapper,
                                 domain: domain)
    }
}
