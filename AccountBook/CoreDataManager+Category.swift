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
    
    func fetchCategories<T: NSManagedObject>(groupId groupId: NSNumber, completion: ((categories: [T]?, error: NSError?) -> Void)?) {
        let fetchRequest = NSFetchRequest()
        
        fetchRequest.entity = NSEntityDescription.entityForName(String(T.self), inManagedObjectContext: managedObjectContext!)
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
    
    func addCategory<T: NSManagedObject>(groupId groupId: NSNumber, name: String, order: NSInteger) -> (category: T?, error: NSError?) {
        let (id, error) = nextIdOfEntity(String(T.self), predicateFormat: "group_id = \(groupId)")
        
        if error != nil {
            return (category: nil, error: error)
        }
        
        let category = NSEntityDescription.insertNewObjectForEntityForName(String(T.self), inManagedObjectContext: managedObjectContext!) as! T
        
        /*
        category.group_id = groupId
        category.id = id
        category.name = name
        category.order = order
        */
        
        if let error = save() {
            return (category: nil, error: error)
        }
        
        return (category: category, error: nil)
    }
}
