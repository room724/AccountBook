//
//  CoreDataManager+GROUP.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 25..
//  Copyright © 2016년 room724. All rights reserved.
//

import CoreData
import Foundation

extension CoreDataManager {
    
    func fetchGroupCount() -> (count: NSInteger, error: NSError?) {
        return fetchObjectCount(objectType: GROUP.self, predicate: nil)
    }
    
    func fetchGroups() -> (groups: [GROUP]?, error: NSError?) {
        let sortDescriptors = [ NSSortDescriptor(key: GROUP.PROP_NAME.ORDER, ascending: true) ]
        return fetchObjects(objectType: GROUP.self, predicate: nil, sortDescriptors: sortDescriptors)
    }
    
    func addGroup(name name: String, order: NSInteger) -> (group: GROUP?, error: NSError?) {
        let predicate = NSPredicate(value: true)
        return addObject(objectType: GROUP.self, predicateForId: predicate) { (object, id) -> Void in
            
            object.id = id
            object.name = name
            object.order = order
        }
    }
    
    func removeGroup(group: GROUP) -> NSError? {
        return removeObject(group)
    }
}
