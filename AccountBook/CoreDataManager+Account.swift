//
//  CoreDataManager+Account.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 25..
//  Copyright © 2016년 room724. All rights reserved.
//

import CoreData
import Foundation

extension CoreDataManager {
    
    func fetchAccountCount(groupId groupId: NSNumber) -> (count: NSInteger, error: NSError?) {
        let predicate = NSPredicate(format: "\(Account.PropertyName.groupId) = \(groupId)", argumentArray: nil)
        return fetchObjectCount(objectType: Account.self, predicate: predicate)
    }
    
    func fetchAccounts(groupId groupId: NSNumber) -> (accounts: [Account]?, error: NSError?) {
        let predicate = NSPredicate(format: "\(Account.PropertyName.groupId) = \(groupId)", argumentArray: nil)
        let sortDescriptors = [ NSSortDescriptor(key: Account.PropertyName.order, ascending: true) ]
        return fetchObjects(objectType: Account.self, predicate: predicate, sortDescriptors: sortDescriptors)
    }
    
    func fetchBookmarkAccounts() -> (accounts: [Account]?, error: NSError?) {
        let predicate = NSPredicate(format: "\(Account.PropertyName.bookmark) = \(true)", argumentArray: nil)
        let sortDescriptors = [ NSSortDescriptor(key: Account.PropertyName.name, ascending: true) ]
        return fetchObjects(objectType: Account.self, predicate: predicate, sortDescriptors: sortDescriptors)
    }
    
    func addAccount(groupId groupId: NSNumber, name: String, order: NSInteger) -> (account: Account?, error: NSError?) {
        let predicate = NSPredicate(format: "\(Account.PropertyName.groupId) = \(groupId)", argumentArray: nil)
        return addObject(objectType: Account.self, predicateForId: predicate) { (object, id) -> Void in
            
            object.id = id
            object.groupId = groupId
            object.name = name
            object.order = order
            object.categoryId = 0 // todo : default
            object.weekStartDay = WeekStartDay.Sunday.rawValue
            object.monthStartDate = 1
            object.carryover = false
            object.bookmark = false
            object.memo = String()
        }
    }
    
    func removeAccounts(groupId groupId: NSNumber) -> NSError? {
        let predicate = NSPredicate(format: "\(Account.PropertyName.groupId) = \(groupId)", argumentArray: nil)
        return removeObjects(objectType: Account.self, predicate: predicate)
    }
    
    func removeAccount(account: Account) -> NSError? {
        return removeObject(account)
    }
}
