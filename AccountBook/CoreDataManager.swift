//
//  CoreDataManager.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 17..
//  Copyright © 2016년 room724. All rights reserved.
//

import CoreData
import Foundation

class CoreDataManager {
    
    static let sharedManager = CoreDataManager()
    
    var managedObjectContext: NSManagedObjectContext?
    
    func setup() -> NSError? {
        let modelURL = NSBundle.mainBundle().URLForResource("AccountBook", withExtension: "momd")!
        let managedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL)!
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let persistentStoreDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last
        let persistentStoreUrl = persistentStoreDirectory?.URLByAppendingPathComponent("AccountBook.sqlite")
        let persistentStoreOptions = [ NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true ]
        
        print("\(__FUNCTION__) url : \(persistentStoreUrl)")
        
        do {
            try persistentStoreCoordinator.addPersistentStoreWithType(
                NSSQLiteStoreType, configuration: nil, URL: persistentStoreUrl, options: persistentStoreOptions)
        } catch {
            return error as NSError
        }
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext!.persistentStoreCoordinator = persistentStoreCoordinator
        
        return nil
    }
    
    func nextIdOfEntity(entityName: String, predicateFormat: String?) -> (id: NSNumber?, error: NSError?) {
        let fetchRequest = NSFetchRequest()
        
        fetchRequest.entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: managedObjectContext!)
        fetchRequest.sortDescriptors = [ NSSortDescriptor(key: "id", ascending: false) ]
        fetchRequest.fetchLimit = 1
        
        if predicateFormat != nil {
            fetchRequest.predicate = NSPredicate(format: predicateFormat!, argumentArray: nil)
        }
        
        do {
            let result = try managedObjectContext!.executeFetchRequest(fetchRequest)
            if result.count == 0 {
                return (id: 0, error: nil)
            }
            
            let id = result.first!.valueForKey("id") as! NSNumber
            return (id: NSNumber(integer: id.integerValue + 1), error: nil)
        } catch {
            return (id: nil, error: error as NSError)
        }
    }
    
    func save() -> NSError? {
        if managedObjectContext!.hasChanges {
            do {
                try managedObjectContext!.save()
            } catch {
                return error as NSError
            }
        }
        
        return nil
    }
}
