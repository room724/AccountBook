//
//  CoreDataManager+IncomeCategory.swift
//  IncomeBook
//
//  Created by inock on 2016. 4. 9..
//  Copyright © 2016년 room724. All rights reserved.
//

import CoreData
import Foundation

extension CoreDataManager {
    
    func defaultIncomeCategoryNames() -> [String] {
        return [
            "월급",
            "용돈",
            "이월",
            "기타",
        ]
    }
    
    func fetchIncomeCategories(groupId groupId: NSNumber) -> (categories: [IncomeCategory]?, error: NSError?) {
        let predicate = NSPredicate(format: "\(IncomeCategory.PropertyName.groupId) = \(groupId)", argumentArray: nil)
        return fetchObjects(objectType: IncomeCategory.self, predicate: predicate, sortDescriptors: nil)
    }
    
    func addDefaultIncomeCategorys(groupId groupId: NSNumber) -> (category: [IncomeCategory]?, error: NSError?) {
        let names = defaultIncomeCategoryNames()
        let predicate = NSPredicate(format: "\(IncomeCategory.PropertyName.groupId) = \(groupId)", argumentArray: nil)
        return addObjects(count: names.count, objectType: IncomeCategory.self, predicateForId: predicate) { (index, object, id) -> Void in
            
            object.id = index
            object.groupId = groupId
            object.name = names[index]
            object.order = index
        }
    }
    
    func addIncomeCategory(groupId groupId: NSNumber, name: String, order: NSInteger) -> (category: IncomeCategory?, error: NSError?) {
        let predicate = NSPredicate(format: "\(IncomeCategory.PropertyName.groupId) = \(groupId)", argumentArray: nil)
        return addObject(objectType: IncomeCategory.self, predicateForId: predicate) { (object, id) -> Void in
            
            object.id = id
            object.groupId = groupId
            object.name = name
            object.order = order
        }
    }
    
    func removeIncomeCategorys(groupId groupId: NSNumber) -> NSError? {
        let predicate = NSPredicate(format: "\(IncomeCategory.PropertyName.groupId) = \(groupId)", argumentArray: nil)
        return removeObjects(objectType: IncomeCategory.self, predicate: predicate)
    }
    
    func removeIncomeCategory(category: IncomeCategory) -> NSError? {
        return removeObject(category)
    }
}