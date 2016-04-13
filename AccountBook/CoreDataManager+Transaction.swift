//
//  CoreDataManager+Transaction.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 25..
//  Copyright © 2016년 room724. All rights reserved.
//

import CoreData
import Foundation

extension CoreDataManager {
    
    func fetchTransactionCount(
        groupId groupId: NSNumber,
        accountId: NSNumber,
        type: TransactionType,
        categoryId: NSNumber) -> (count: NSInteger, error: NSError?)
    {
        let predicateFormats = [
            "\(Transaction.PropertyName.groupId) = \(groupId)",
            "\(Transaction.PropertyName.accountId) = \(accountId)",
            "\(Transaction.PropertyName.type) = \(type.rawValue)",
            "\(Transaction.PropertyName.categoryId) = \(categoryId)"
        ]
        let predicate = NSPredicate(format: predicateFormats.joinWithSeparator(" AND "), argumentArray: nil)
        return fetchObjectCount(objectType: Transaction.self, predicate: predicate)
    }
    
    func fetchTransactions(
        groupId groupId: NSNumber,
        accountId: NSNumber,
        startDate: NSDate,
        endDate: NSDate) -> (transactions: [Transaction]?, error: NSError? )
    {
        let predicateFormats = [
            "\(Transaction.PropertyName.groupId) = \(groupId)",
            "\(Transaction.PropertyName.accountId) = \(accountId)",
            "\(Transaction.PropertyName.date) >= \(startDate)",
            "\(Transaction.PropertyName.date) <= \(endDate)"
        ]
        let predicate = NSPredicate(format: predicateFormats.joinWithSeparator(" AND "), argumentArray: nil)
        let sortDescriptors = [ NSSortDescriptor(key: Transaction.PropertyName.date, ascending: false) ]
        return fetchObjects(objectType: Transaction.self, predicate: predicate, sortDescriptors: sortDescriptors)
    }
    
    func addTransaction(
        groupId groupId: NSNumber,
        accountId: NSNumber,
        type: TransactionType,
        categoryId: NSNumber,
        name: String,
        money: NSInteger,
        cardId: NSNumber?) -> (transaction: Transaction?, error: NSError?)
    {
        let predicateFormats = [
            "\(Transaction.PropertyName.groupId) = \(groupId)",
            "\(Transaction.PropertyName.accountId) = \(accountId)"
        ]
        let predicate = NSPredicate(format: predicateFormats.joinWithSeparator(" AND "), argumentArray: nil)
        return addObject(objectType: Transaction.self, predicateForId: predicate) { (object, id) -> Void in
            
            object.id = id
            object.groupId = groupId
            object.accountId = accountId
            object.type = type.rawValue
            object.categoryId = categoryId
            object.name = name
            object.money = money
            object.cardId = cardId
            object.memo = String()
            object.date = NSDate()
        }
    }
    
    func removeTransactions(
        groupId groupId: NSNumber,
        accountId: NSNumber) -> NSError?
    {
        let predicateFormats = [
            "\(Transaction.PropertyName.groupId) = \(groupId)",
            "\(Transaction.PropertyName.accountId) = \(accountId)"
        ]
        let predicate = NSPredicate(format: predicateFormats.joinWithSeparator(" AND "), argumentArray: nil)
        return removeObjects(objectType: Transaction.self, predicate: predicate)
    }
    
    func removeTransaction(transaction: Transaction) -> NSError? {
        return removeObject(transaction)
    }
}
