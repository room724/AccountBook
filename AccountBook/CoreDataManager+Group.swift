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
    
    func fetchGroupCount() -> (count: NSInteger, error: NSError?) {
        return fetchObjectCount(objectType: Group.self, predicate: nil)
    }
    
    func fetchGroups() -> (groups: [Group]?, error: NSError?) {
        let sortDescriptors = [ NSSortDescriptor(key: Group.PropertyName.order, ascending: true) ]
        return fetchObjects(objectType: Group.self, predicate: nil, sortDescriptors: sortDescriptors)
    }
    
    func addGroup(name name: String, order: NSInteger) -> (group: Group?, error: NSError?) {
        let predicate = NSPredicate(value: true)
        let result: (group: Group?, error: NSError?) = addObject(objectType: Group.self, predicateForId: predicate) { (object, id) -> Void in
            
            object.id = id
            object.name = name
            object.order = order
        }
        
        if result.error == nil {
            let groupId = result.group!.id!
            
            addDefaultCards(groupId: groupId, type: .Check)
            addDefaultCards(groupId: groupId, type: .Credit)
            
            addDefaultCategorys(groupId: groupId, type: .Account)
            addDefaultCategorys(groupId: groupId, type: .Income)
            addDefaultCategorys(groupId: groupId, type: .Expense)
        }
        
        return result
    }
    
    func removeGroup(group: Group) -> NSError? {
        return removeObject(group)
    }
}
