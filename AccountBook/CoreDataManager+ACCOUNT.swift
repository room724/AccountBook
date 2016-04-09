//
//  CoreDataManager+ACCOUNT.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 25..
//  Copyright © 2016년 room724. All rights reserved.
//

import CoreData
import Foundation

extension CoreDataManager {
    
    func fetchAccountCount(groupId groupId: NSNumber) -> (count: NSInteger, error: NSError?) {
        let predicate = NSPredicate(format: "\(ACCOUNT.PROP_NAME.GROUP_ID) = \(groupId)", argumentArray: nil)
        return fetchObjectCount(objectType: ACCOUNT.self, predicate: predicate)
    }
    
    func fetchAccounts(groupId groupId: NSNumber) -> (accounts: [ACCOUNT]?, error: NSError?) {
        let predicate = NSPredicate(format: "\(ACCOUNT.PROP_NAME.GROUP_ID) = \(groupId)", argumentArray: nil)
        let sortDescriptors = [ NSSortDescriptor(key: ACCOUNT.PROP_NAME.ORDER, ascending: true) ]
        return fetchObjects(objectType: ACCOUNT.self, predicate: predicate, sortDescriptors: sortDescriptors)
    }
    
    func fetchBookmarkAccounts() -> (accounts: [ACCOUNT]?, error: NSError?) {
        let predicate = NSPredicate(format: "\(ACCOUNT.PROP_NAME.BOOKMARK) = \(true)", argumentArray: nil)
        let sortDescriptors = [ NSSortDescriptor(key: ACCOUNT.PROP_NAME.NAME, ascending: true) ]
        return fetchObjects(objectType: ACCOUNT.self, predicate: predicate, sortDescriptors: sortDescriptors)
    }
    
    func addAccount(groupId groupId: NSNumber, name: String, order: NSInteger) -> (account: ACCOUNT?, error: NSError?) {
        let predicate = NSPredicate(format: "\(ACCOUNT.PROP_NAME.GROUP_ID) = \(groupId)", argumentArray: nil)
        return addObject(objectType: ACCOUNT.self, predicateForId: predicate) { (object, id) -> Void in
            
            object.id = id
            object.group_id = groupId
            object.name = name
            object.order = order
            object.category_id = 0 // todo : default
            object.week_start_day = WEEK_START_DAY.SUNDAY.rawValue
            object.month_start_date = 1
            object.carryover = false
            object.bookmark = false
            object.memo = String()
        }
    }
    
    func removeAccounts(groupId groupId: NSNumber) -> NSError? {
        let predicate = NSPredicate(format: "\(ACCOUNT.PROP_NAME.GROUP_ID) = \(groupId)", argumentArray: nil)
        return removeObjects(objectType: ACCOUNT.self, predicate: predicate)
    }
    
    func removeAccount(account: ACCOUNT) -> NSError? {
        return removeObject(account)
    }
}
