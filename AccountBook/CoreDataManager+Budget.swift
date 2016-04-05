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
    
    func getBudget(accountId accountId: NSNumber, type: BudgetType, categoryId: NSNumber) -> (budget: BUDGET?, error: NSError?) {
        let (budgets, error) = getBudgets(predicateFormat: "account_id = \(accountId) AND type = \(type) AND category_id = \(categoryId)")
        return (budget: budgets?.first, error: error)
    }
    
    func addBudget(accountId accountId: NSNumber, type: BudgetType, categoryId: NSNumber, money: NSInteger) -> (budget: BUDGET?, error: NSError?) {
        let budget = NSEntityDescription.insertNewObjectForEntityForName("BUDGET", inManagedObjectContext: managedObjectContext!) as! BUDGET
        
        budget.account_id = accountId
        budget.type = type.rawValue
        budget.category_id = categoryId
        budget.money = money
        
        if let error = save() {
            return (budget: nil, error: error)
        }
        
        return (budget: budget, error: nil)
    }
    
    func removeBudgets(accountId accountId: NSNumber) -> NSError? {
        return removeBudgets(predicateFormat: "account_id = \(accountId)")
    }
    
    func removeBudgets(accountId accountId: NSNumber, type: BudgetType, categoryId: NSNumber) -> NSError? {
        return removeBudgets(predicateFormat: "account_id = \(accountId) AND type = \(type) AND category_id = \(categoryId)")
    }
    
    func removeBudget(budget: BUDGET) -> NSError? {
        managedObjectContext!.deleteObject(budget)
        return save()
    }
    
    // MARK: - Private
    
    private func getBudgets(predicateFormat predicateFormat: String) -> (budgets: [BUDGET]?, error: NSError?) {
        let fetchRequest = NSFetchRequest()
        
        fetchRequest.entity = NSEntityDescription.entityForName("BUDGET", inManagedObjectContext: managedObjectContext!)
        fetchRequest.predicate = NSPredicate(format: predicateFormat, argumentArray: nil)
        
        var budgets: [BUDGET]
        
        do {
            budgets = try managedObjectContext!.executeFetchRequest(fetchRequest) as! [BUDGET]
        } catch {
            return (budgets: nil, error: error as NSError)
        }
        
        return (budgets: budgets, error: nil)
    }
    
    private func removeBudgets(predicateFormat predicateFormat: String) -> NSError? {
        let (budgets, error) = getBudgets(predicateFormat: predicateFormat)
        
        if error != nil {
            return error
        }
        
        for budget in budgets! {
            if let error = removeBudget(budget) {
                return error
            }
        }
        
        return nil
    }
}
