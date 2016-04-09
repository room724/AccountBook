//
//  CoreDataManager+Budget.swift
//  AccountBook
//
//  Created by inock on 2016. 4. 6..
//  Copyright © 2016년 room724. All rights reserved.
//

import CoreData
import Foundation

extension CoreDataManager {
    
    func fetchBudget(
        groupId groupId: NSNumber,
        accountId: NSNumber,
        type: BudgetType,
        categoryId: NSNumber) -> (budget: Budget?, error: NSError?)
    {
        let predicateFormats = [
            "\(Budget.PropertyName.groupId) = \(groupId)",
            "\(Budget.PropertyName.accountId) = \(accountId)",
            "\(Budget.PropertyName.type) = \(type)",
            "\(Budget.PropertyName.categoryId) = \(categoryId)"
        ]
        
        let predicate = NSPredicate(format: predicateFormats.joinWithSeparator("AND"), argumentArray: nil)
        let (budgets, error) = fetchObjects(objectType: Budget.self, predicate: predicate, sortDescriptors: nil)
        return (budget: budgets?.first, error: error)
    }
    
    func addBudget(
        groupId groupId: NSNumber,
        accountId: NSNumber,
        type: BudgetType,
        categoryId: NSNumber,
        money: NSInteger) -> (budget: Budget?, error: NSError?)
    {
        return addObject(objectType: Budget.self, predicateForId: nil) { (object, id) -> Void in
            
            object.groupId = groupId
            object.accountId = accountId
            object.type = type.rawValue
            object.categoryId = categoryId
            object.money = money
        }
    }
    
    func removeBudgets(
        groupId groupId: NSNumber,
        accountId: NSNumber) -> NSError?
    {
        let predicateFormats = [
            "\(Budget.PropertyName.groupId) = \(groupId)",
            "\(Budget.PropertyName.accountId) = \(accountId)"
        ]
        
        let predicate = NSPredicate(format: predicateFormats.joinWithSeparator("AND"), argumentArray: nil)
        return removeObjects(objectType: Budget.self, predicate: predicate)
    }
}
