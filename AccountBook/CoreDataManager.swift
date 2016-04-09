//
//  CoreDataManager.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 17..
//  Copyright © 2016년 room724. All rights reserved.
//

import CoreData
import Foundation

let CORE_DATA_MANAGER = CoreDataManager.sharedManager

class CoreDataManager {
    static let sharedManager = CoreDataManager()
    
    // MARK: -
    
    var managedObjectContext: NSManagedObjectContext?
    
    // MARK: -
    
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
    
    // MARK: -
    
    func fetchObjectNextId<T: NSManagedObject>(
        objectType objectType: T.Type,
        predicate: NSPredicate?) -> (id: NSNumber?, error: NSError?)
    {
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = NSEntityDescription.entityForName(String(T.self), inManagedObjectContext: managedObjectContext!)
        fetchRequest.sortDescriptors = [ NSSortDescriptor(key: "id", ascending: false) ]
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        
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
    
    func fetchObjectCount<T: NSManagedObject>(
        objectType objectType: T.Type,
        predicate: NSPredicate?) -> (count: NSInteger, error: NSError?)
    {
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = NSEntityDescription.entityForName(String(T.self), inManagedObjectContext: managedObjectContext!)
        fetchRequest.predicate = predicate
        fetchRequest.includesSubentities = false
        fetchRequest.includesPropertyValues = false
        
        var error: NSError?
        let count = managedObjectContext!.countForFetchRequest(fetchRequest, error: &error)
        return (count : count, error: error)
    }
    
    func fetchObjects<T: NSManagedObject>(
        objectType objectType: T.Type,
        predicate: NSPredicate?,
        sortDescriptors: [NSSortDescriptor]?) -> ([T]?, NSError?)
    {
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = NSEntityDescription.entityForName(String(T.self), inManagedObjectContext: managedObjectContext!)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        var objects: [T]
        
        do {
            objects = try managedObjectContext!.executeFetchRequest(fetchRequest) as! [T]
        } catch {
            return (nil, error as NSError)
        }
        
        return (objects, nil)
    }
    
    func addObjects<T: NSManagedObject>(
        count count: NSInteger,
        objectType: T.Type,
        predicateForId: NSPredicate?,
        updateBlock: ((index: NSInteger, object: T, id: NSNumber) -> Void)?) -> ([T]?, NSError?)
    {
        var nextId: NSNumber?
        
        if predicateForId != nil {
            let (id, error) = fetchObjectNextId(objectType: objectType, predicate: predicateForId)
            
            if error != nil {
                return (nil, error)
            }
            
            nextId = id!
        }
        
        var objects: [T] = [T]()
        
        for i in 0 ..< count {
            let object = NSEntityDescription.insertNewObjectForEntityForName(String(objectType), inManagedObjectContext: managedObjectContext!) as! T
            
            if updateBlock != nil {
                updateBlock!(index: i, object: object, id: nextId ?? -1)
            }
            
            objects.append(object)
            
            if nextId != nil {
                nextId = NSNumber(integer: nextId!.integerValue + 1)
            }
        }
        
        if let error = save() {
            return (objects, error)
        }
        
        return (objects, nil)
    }
    
    func addObject<T: NSManagedObject>(
        objectType objectType: T.Type,
        predicateForId: NSPredicate?,
        updateBlock: ((object: T, id: NSNumber) -> Void)?) -> (T?, NSError?)
    {
        let (objects, error) = addObjects(count: 1, objectType: objectType, predicateForId: predicateForId) { (index, object, id) -> Void in
            updateBlock!(object: object, id: id)
        }
        return (objects?.first, error)
    }
    
    func removeObjects<T: NSManagedObject>(
        objectType objectType: T.Type,
        predicate: NSPredicate?) -> NSError?
    {
        let fetchRequest = NSFetchRequest()
        fetchRequest.entity = NSEntityDescription.entityForName(String(T.self), inManagedObjectContext: managedObjectContext!)
        fetchRequest.predicate = predicate
        fetchRequest.includesSubentities = false
        fetchRequest.includesPropertyValues = false
        
        var objects: [T]
        
        do {
            objects = try managedObjectContext!.executeFetchRequest(fetchRequest) as! [T]
        } catch {
            return error as NSError
        }
        
        for object in objects {
            managedObjectContext!.deleteObject(object)
        }
        
        return save()
    }
    
    func removeObject<T: NSManagedObject>(object: T) -> NSError? {
        managedObjectContext!.deleteObject(object)
        return save()
    }
}
