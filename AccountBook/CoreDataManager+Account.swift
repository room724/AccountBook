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

    func fetchAccounts(groupId groupId: NSNumber, completion: ((accounts: [ACCOUNT]?, error: NSError?) -> Void)?) {
        let fetchRequest = NSFetchRequest()
        
        fetchRequest.entity = NSEntityDescription.entityForName("ACCOUNT", inManagedObjectContext: managedObjectContext!)
        fetchRequest.predicate = NSPredicate(format: "group_id = \(groupId)", argumentArray: nil)
        fetchRequest.sortDescriptors = [ NSSortDescriptor(key: "order", ascending: true) ]
        
        let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (asynchronousFetchResult) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let accounts = asynchronousFetchResult.finalResult as? [ACCOUNT]
                completion?(accounts: accounts, error: nil)
            })
        }
        
        do {
            try managedObjectContext!.executeRequest(asynchronousFetchRequest)
        } catch {
            completion?(accounts: nil, error: error as NSError)
        }
    }
    
    func fetchBookmarkAccounts(completion: ((accounts: [ACCOUNT]?, error: NSError?) -> Void)?) {
        let fetchRequest = NSFetchRequest()
        
        fetchRequest.entity = NSEntityDescription.entityForName("ACCOUNT", inManagedObjectContext: managedObjectContext!)
        fetchRequest.predicate = NSPredicate(format: "bookmark = \(true)", argumentArray: nil)
        fetchRequest.sortDescriptors = [ NSSortDescriptor(key: "name", ascending: true) ]
        
        let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (asynchronousFetchResult) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let accounts = asynchronousFetchResult.finalResult as? [ACCOUNT]
                completion?(accounts: accounts, error: nil)
            })
        }
        
        do {
            try managedObjectContext!.executeRequest(asynchronousFetchRequest)
        } catch {
            completion?(accounts: nil, error: error as NSError)
        }
    }
    
    func getAccountCount(groupId groupId: NSNumber) -> (count: NSInteger, error: NSError?) {
        let fetchRequest = NSFetchRequest()
        
        fetchRequest.entity = NSEntityDescription.entityForName("ACCOUNT", inManagedObjectContext: managedObjectContext!)
        fetchRequest.predicate = NSPredicate(format: "group_id = \(groupId)", argumentArray: nil)
        fetchRequest.includesPropertyValues = false
        
        var error: NSError?
        let count = managedObjectContext!.countForFetchRequest(fetchRequest, error: &error)
        
        return (count : count, error: error)
    }
    
    func addAccount(groupId groupId: NSNumber, name: String, order: NSInteger) -> (account: ACCOUNT?, error: NSError?) {
        let (id, error) = nextIdOfEntity("ACCOUNT", predicateFormat: "group_id = \(groupId)")
        
        if error != nil {
            return (account: nil, error: error)
        }
        
        let account = NSEntityDescription.insertNewObjectForEntityForName("ACCOUNT", inManagedObjectContext: managedObjectContext!) as! ACCOUNT
        
        account.group_id = groupId
        account.id = id
        account.name = name
        account.order = order
        account.category_id = 0 // todo
        account.week_start_day = NSNumber(integer: WeekStartDay.Sunday.rawValue)
        account.month_start_date = 1
        account.carryover = false
        account.bookmark = false
        account.memo = String()
        
        if let error = save() {
            return (account: nil, error: error)
        }
        
        return (account: account, error: nil)
    }
    
    func removeAccounts(groupId groupId: NSNumber) -> NSError? {
        let fetchRequest = NSFetchRequest()
        
        fetchRequest.entity = NSEntityDescription.entityForName("ACCOUNT", inManagedObjectContext: managedObjectContext!)
        fetchRequest.predicate = NSPredicate(format: "group_id = \(groupId)", argumentArray: nil)
        
        var accounts: [ACCOUNT]
        
        do {
            accounts = try managedObjectContext!.executeFetchRequest(fetchRequest) as! [ACCOUNT]
        } catch {
            return error as NSError
        }
        
        for account in accounts {
            if let error = removeAccount(account) {
                return error
            }
        }
        
        return nil
    }
    
    func removeAccount(account: ACCOUNT) -> NSError? {
        if let error = removeBudgets(accountId: account.id!) {
            return error
        }
        
        // todo : delete entity -> transaction
        
        managedObjectContext!.deleteObject(account)
        return save()
    }
}
