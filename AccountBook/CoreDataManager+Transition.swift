//
//  CoreDataManager+Transition.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 25..
//  Copyright © 2016년 room724. All rights reserved.
//

import CoreData
import Foundation

extension CoreDataManager {
    
    //
    
    func getTransactionCount(accountId accountId: NSNumber, type: TransactionType, categoryId: NSNumber) -> (count: NSInteger, error: NSError?) {
        let fetchRequest = NSFetchRequest()
        
        fetchRequest.entity = NSEntityDescription.entityForName("TRANSACTION", inManagedObjectContext: managedObjectContext!)
        fetchRequest.predicate = NSPredicate(format: "account_id = \(accountId) AND type = \(type) AND category_id = \(categoryId)", argumentArray: nil)
        fetchRequest.includesPropertyValues = false
        
        var error: NSError?
        let count = managedObjectContext!.countForFetchRequest(fetchRequest, error: &error)
        
        return (count : count, error: error)
    }
}
