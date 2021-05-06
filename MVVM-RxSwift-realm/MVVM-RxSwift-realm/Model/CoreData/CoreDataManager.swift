//
//  CoreDataManager.swift
//  MVVM-RxSwift-coreData
//
//  Created by GoEun Jeong on 2021/05/05.
//

import CoreData
class CoreDataManager {
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Beer")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchRequest(id: Int) -> NSFetchRequest<BeerEntity> {
        let request: NSFetchRequest = BeerEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %d", id)
        return request
    }
    
    private func deleteResponse(id: Int, in context: NSManagedObjectContext) {
        let request = fetchRequest(id: id)
        do {
            if let result = try context.fetch(request).first {
                context.delete(result)
            }
        } catch {
            print(error)
        }
    }
    
    func save(for requestDto: Beer) {
        self.persistentContainer.performBackgroundTask { context in
            do {
                self.deleteResponse(id: requestDto.id ?? 0, in: context)
                
                _ = requestDto.toEntity(in: context)

                try context.save()
            } catch {
                // TODO: - Log to Crashlytics
                debugPrint("CoreDataMoviesResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
    
}

extension NSManagedObjectContext {
    
    func fetchData(predicate: NSPredicate? = nil) -> Array<Any> {
//        let entityName = String(describing: entity.self)
//        let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: self)
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let request: NSFetchRequest = BeerEntity.fetchRequest()
        request.returnsObjectsAsFaults = false
        
        /// If predicate found then filter based on that
        if let predicate = predicate {
            request.predicate = predicate
        }
        do {
            let result = try self.fetch(request)
            return result
        } catch {
            fatalError("Failed to fetch BeerEntity: \(error)")
        }
    }
}

