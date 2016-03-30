//
//  CoreDataManager+Group.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 25..
//  Copyright © 2016년 room724. All rights reserved.
//

import CoreData
import Foundation

extension CoreDataManager {
    
    func fetchGroups(completion: ((groups: [GROUP]?, error: NSError?) -> Void)?) {
        let fetchRequest = NSFetchRequest()
        
        fetchRequest.entity = NSEntityDescription.entityForName("GROUP", inManagedObjectContext: managedObjectContext!)
        fetchRequest.sortDescriptors = [ NSSortDescriptor(key: "order", ascending: true) ]
        
        let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (asynchronousFetchResult) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let groups = asynchronousFetchResult.finalResult as? [GROUP]
                completion?(groups: groups, error: nil)
            })
        }
        
        do {
            try managedObjectContext!.executeRequest(asynchronousFetchRequest)
        } catch {
            completion?(groups: nil, error: error as NSError)
        }
    }
    
    func addGroup(name name: String, order: NSInteger) -> (group: GROUP?, error: NSError?) {
        let (id, error) = nextIdOfEntity("GROUP", predicateFormat: nil)
        
        if error != nil {
            return (group: nil, error: error)
        }
        
        let group = NSEntityDescription.insertNewObjectForEntityForName("GROUP", inManagedObjectContext: managedObjectContext!) as! GROUP
        
        group.id = id
        group.name = name
        group.order = order
        
        if let error = save() {
            return (group: nil, error: error)
        }
        
        return (group: group, error: nil)
    }
    
    func removeGroup(group: GROUP) -> NSError? {
        managedObjectContext!.deleteObject(group)
        
        if let error = save() {
            return error
        }
        
        return nil
    }
}
