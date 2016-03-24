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
    
    var groups: [GROUP]?
    
    func setup () -> NSError? {
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
    
    func fetchGroups (completion: (NSError? -> Void)?) {
        let fetchRequest = NSFetchRequest()
        
        fetchRequest.entity = NSEntityDescription.entityForName("GROUP", inManagedObjectContext: managedObjectContext!)
        fetchRequest.sortDescriptors = [ NSSortDescriptor(key: "order", ascending: true) ]
        
        let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (asynchronousFetchResult) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.groups = asynchronousFetchResult.finalResult as? [GROUP]
                completion?(nil)
            })
        }
        
        do {
            try managedObjectContext!.executeRequest(asynchronousFetchRequest)
        } catch {
            completion?(error as NSError)
        }
    }
    
    func addGroup (name: String, order: NSInteger) -> NSError? {
        let group = NSEntityDescription.insertNewObjectForEntityForName("GROUP", inManagedObjectContext: managedObjectContext!) as! GROUP
        
        group.id = 3 // todo
        group.name = name
        group.order = order
        
        if let error = save() {
            return error
        }
        
        self.groups!.append(group)
        return nil
    }
    
    func save () -> NSError? {
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
