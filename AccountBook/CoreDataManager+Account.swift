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

    func fetchAccountsWithGroupId(groupId: NSNumber, completion: ((accounts: [ACCOUNT]?, error: NSError?) -> Void)?) {
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
    
    func fetchFavoriteAccounts(completion: ((accounts: [ACCOUNT]?, error: NSError?) -> Void)?) {
        let fetchRequest = NSFetchRequest()
        
        fetchRequest.entity = NSEntityDescription.entityForName("ACCOUNT", inManagedObjectContext: managedObjectContext!)
        fetchRequest.predicate = NSPredicate(format: "favorite = true", argumentArray: nil)
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
    
    func addAccountWithGroupId(groupId: NSNumber, name: String, order: NSInteger) -> (account: ACCOUNT?, error: NSError?) {
        let (id, error) = nextIdOfEntity("ACCOUNT", predicateFormat: "group_id=\(groupId)")
        
        if error != nil {
            return (account: nil, error: error)
        }
        
        let account = NSEntityDescription.insertNewObjectForEntityForName("ACCOUNT", inManagedObjectContext: managedObjectContext!) as! ACCOUNT
        
        account.group_id = groupId
        account.id = id
        account.name = name
        account.order = order
        account.category_id = 1 // todo
        account.week_start_day = 1 // todo
        account.month_start_date = 25 // todo
        account.carryover = false
        account.favorite = false
        account.memo = String()
        
        if let error = save() {
            return (account: nil, error: error)
        }
        
        return (account: account, error: nil)
    }
    
    func removeAccount(account: ACCOUNT) -> NSError? {
        managedObjectContext!.deleteObject(account)
        
        if let error = save() {
            return error
        }
        
        return nil
    }
}
