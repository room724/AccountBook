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
    
    func fetchTransactionCount(
        groupId
        groupId: NSNumber,
        accountId: NSNumber,
        type: TransactionType,
        categoryId: NSNumber) -> (count: NSInteger, error: NSError?) {
            
        let predicateFormats = [
            "\(TRANSACTION.PROP_NAME.GROUP_ID) = \(groupId)",
            "\(TRANSACTION.PROP_NAME.ACCOUNT_ID) = \(accountId)",
            "\(TRANSACTION.PROP_NAME.TYPE) = \(type)",
            "\(TRANSACTION.PROP_NAME.CATEGORY_ID) = \(categoryId)"
        ]
        
        let predicate = NSPredicate(format: predicateFormats.joinWithSeparator("AND"), argumentArray: nil)
        return fetchObjectCount(objectType: TRANSACTION.self, predicate: predicate)
    }
    
    func fetchTransactions(
        groupId
        groupId: NSNumber,
        accountId: NSNumber,
        startDate: NSDate,
        endDate: NSDate) -> (transactions: [TRANSACTION]?, error: NSError? ) {
            
        let predicateFormats = [
            "\(TRANSACTION.PROP_NAME.GROUP_ID) = \(groupId)",
            "\(TRANSACTION.PROP_NAME.ACCOUNT_ID) = \(accountId)",
            "\(TRANSACTION.PROP_NAME.DATE) >= \(startDate)",
            "\(TRANSACTION.PROP_NAME.DATE) <= \(endDate)"
        ]
        
        let predicate = NSPredicate(format: predicateFormats.joinWithSeparator("AND"), argumentArray: nil)
        let sortDescriptors = [ NSSortDescriptor(key: TRANSACTION.PROP_NAME.DATE, ascending: false) ]
        return fetchObjects(objectType: TRANSACTION.self, predicate: predicate, sortDescriptors: sortDescriptors)
    }
    
    func addTransaction(
        groupId
        groupId: NSNumber,
        accountId: NSNumber,
        type: TransactionType,
        categoryId: NSNumber,
        name: String,
        money: NSInteger,
        cardId: NSNumber?) -> (transaction: TRANSACTION?, error: NSError?) {
        
        let predicateFormats = [
            "\(TRANSACTION.PROP_NAME.GROUP_ID) = \(groupId)",
            "\(TRANSACTION.PROP_NAME.ACCOUNT_ID) = \(accountId)"
        ]
        
        let predicate = NSPredicate(format: predicateFormats.joinWithSeparator("AND"), argumentArray: nil)
        return addObject(objectType: TRANSACTION.self, predicateForId: predicate) { (object, id) -> Void in
            
            object.id = id
            object.group_id = groupId
            object.account_id = accountId
            object.type = type.rawValue
            object.category_id = categoryId
            object.name = name
            object.money = money
            object.card_id = cardId
            object.memo = String()
            object.date = NSDate()
        }
    }
    
    func removeTransactions(
        groupId
        groupId: NSNumber,
        accountId: NSNumber) -> NSError? {
            
        let predicateFormats = [
            "\(TRANSACTION.PROP_NAME.GROUP_ID) = \(groupId)",
            "\(TRANSACTION.PROP_NAME.ACCOUNT_ID) = \(accountId)"
        ]
        
        let predicate = NSPredicate(format: predicateFormats.joinWithSeparator("AND"), argumentArray: nil)
        return removeObjects(objectType: TRANSACTION.self, predicate: predicate)
    }
    
    func removeTransaction(transaction: TRANSACTION) -> NSError? {
        return removeObject(transaction)
    }
}
