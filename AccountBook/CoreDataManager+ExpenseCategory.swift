//
//  CoreDataManager+ExpenseCategory.swift
//  ExpenseBook
//
//  Created by inock on 2016. 4. 9..
//  Copyright © 2016년 room724. All rights reserved.
//

import CoreData
import Foundation

extension CoreDataManager {
    
    func defaultExpenseCategoryNames() -> [String] {
        return [
            "식비",
            "교통비",
            "문화생활",
            "생필품",
            "의류",
            "미용",
            "의료/건강",
            "교육",
            "통신비",
            "회비",
            "경조사",
            "저축", // todo : sub - 적금,펀드,보험,투자,기타
            "가전",
            "공과금",
            "관리비",
            "카드대금",
            "기타"
        ]
    }
    
    func fetchExpenseCategories(groupId groupId: NSNumber) -> (categories: [ExpenseCategory]?, error: NSError?) {
        let predicate = NSPredicate(format: "\(ExpenseCategory.PropertyName.groupId) = \(groupId)", argumentArray: nil)
        return fetchObjects(objectType: ExpenseCategory.self, predicate: predicate, sortDescriptors: nil)
    }
    
    func addDefaultExpenseCategorys(groupId groupId: NSNumber) -> (category: [ExpenseCategory]?, error: NSError?) {
        let names = defaultExpenseCategoryNames()
        let predicate = NSPredicate(format: "\(ExpenseCategory.PropertyName.groupId) = \(groupId)", argumentArray: nil)
        return addObjects(count: names.count, objectType: ExpenseCategory.self, predicateForId: predicate) { (index, object, id) -> Void in
            
            object.id = index
            object.groupId = groupId
            object.name = names[index]
            object.order = index
        }
    }
    
    func addExpenseCategory(groupId groupId: NSNumber, name: String, order: NSInteger) -> (category: ExpenseCategory?, error: NSError?) {
        let predicate = NSPredicate(format: "\(ExpenseCategory.PropertyName.groupId) = \(groupId)", argumentArray: nil)
        return addObject(objectType: ExpenseCategory.self, predicateForId: predicate) { (object, id) -> Void in
            
            object.id = id
            object.groupId = groupId
            object.name = name
            object.order = order
        }
    }
    
    func removeExpenseCategorys(groupId groupId: NSNumber) -> NSError? {
        let predicate = NSPredicate(format: "\(ExpenseCategory.PropertyName.groupId) = \(groupId)", argumentArray: nil)
        return removeObjects(objectType: ExpenseCategory.self, predicate: predicate)
    }
    
    func removeExpenseCategory(category: ExpenseCategory) -> NSError? {
        return removeObject(category)
    }
}