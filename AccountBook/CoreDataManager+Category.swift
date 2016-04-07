//
//  CoreDataManager+Category.swift
//  AccountBook
//
//  Created by inock on 2016. 4. 6..
//  Copyright © 2016년 room724. All rights reserved.
//

import CoreData
import Foundation

extension CoreDataManager {
    
    //
    
    // MARK: - Private
    
    private func fetchCategories<T: NSManagedObject>(groupId groupId: NSNumber, completion: ((categories: [T]?, error: NSError?) -> Void)?) {
        let entityName = String(T.self)
        
        if !entityName.hasPrefix("CATEGORY_") {
            completion?(categories: nil, error: nil)
            return
        }
        
        let fetchRequest = NSFetchRequest()
        
        fetchRequest.entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: managedObjectContext!)
        fetchRequest.predicate = NSPredicate(format: "group_id = \(groupId)", argumentArray: nil)
        fetchRequest.sortDescriptors = [ NSSortDescriptor(key: "order", ascending: true) ]
        
        let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (asynchronousFetchResult) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion?(categories: asynchronousFetchResult.finalResult as? [T], error: nil)
            })
        }
        
        do {
            try managedObjectContext!.executeRequest(asynchronousFetchRequest)
        } catch {
            completion?(categories: nil, error: error as NSError)
        }
    }
    
    private func addCategory<T: NSManagedObject>(groupId groupId: NSNumber, name: String, order: NSInteger) -> (category: T?, error: NSError?) {
        let entityName = String(T.self)
        
        if !entityName.hasPrefix("CATEGORY_") {
            return (category: nil, error: nil)
        }
        
        let (id, error) = nextIdOfEntity(entityName, predicateFormat: "group_id = \(groupId)")
        
        if error != nil {
            return (category: nil, error: error)
        }
        
        let category = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: managedObjectContext!) as! T
        
        if let category: NSManagedObject = category {
            
            category.setValue(groupId, forKey: "group_id")
            category.setValue(id, forKey: "id")
            category.setValue(name, forKey: "name")
            category.setValue(order, forKey: "order")
        }
        
        if let error = save() {
            return (category: nil, error: error)
        }
        
        return (category: category, error: nil)
    }
    
    private func removeCategory<T: NSManagedObject>(category: T) -> NSError? {
        let entityName = String(T.self)
        
        if !entityName.hasPrefix("CATEGORY_") {
            return nil
        }
        
        managedObjectContext!.deleteObject(category)
        return save()
    }
}
