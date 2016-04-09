//
//  CoreDataManager+BUDGET.swift
//  AccountBook
//
//  Created by inock on 2016. 4. 6..
//  Copyright © 2016년 room724. All rights reserved.
//

import CoreData
import Foundation

extension CoreDataManager {
    
    func fetchBudget(
        groupId
        groupId: NSNumber,
        accountId: NSNumber,
        type: BUDGET_TYPE,
        categoryId: NSNumber) -> (budget: BUDGET?, error: NSError?) {
            
        let predicateFormats = [
            "\(BUDGET.PROP_NAME.GROUP_ID) = \(groupId)",
            "\(BUDGET.PROP_NAME.ACCOUNT_ID) = \(accountId)",
            "\(BUDGET.PROP_NAME.TYPE) = \(type)",
            "\(BUDGET.PROP_NAME.CATEGORY_ID) = \(categoryId)"
        ]
        
        let predicate = NSPredicate(format: predicateFormats.joinWithSeparator("AND"), argumentArray: nil)
        let (budgets, error) = fetchObjects(objectType: BUDGET.self, predicate: predicate, sortDescriptors: nil)
        return (budget: budgets?.first, error: error)
    }
    
    func addBudget(
        groupId
        groupId: NSNumber,
        accountId: NSNumber,
        type: BUDGET_TYPE,
        categoryId: NSNumber,
        money: NSInteger) -> (budget: BUDGET?, error: NSError?) {
            
        return addObject(objectType: BUDGET.self, predicateForId: nil) { (object, id) -> Void in
            
            object.group_id = groupId
            object.account_id = accountId
            object.type = type.rawValue
            object.category_id = categoryId
            object.money = money
        }
    }
    
    func removeBudgets(
        groupId
        groupId: NSNumber,
        accountId: NSNumber) -> NSError? {
            
        let predicateFormats = [
            "\(BUDGET.PROP_NAME.GROUP_ID) = \(groupId)",
            "\(BUDGET.PROP_NAME.ACCOUNT_ID) = \(accountId)"
        ]
        
        let predicate = NSPredicate(format: predicateFormats.joinWithSeparator("AND"), argumentArray: nil)
        return removeObjects(objectType: BUDGET.self, predicate: predicate)
    }
}
