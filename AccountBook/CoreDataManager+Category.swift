//
//  CoreDataManager+Category.swift
//  AccountBook
//
//  Created by inock on 2016. 4. 6..
//  Copyright © 2016년 room724. All rights reserved.
//

import CoreData
import Foundation

extension CoreDataManager {
    
    func defaultCategoryNames(type: CategoryType) -> [String]? {
        if type == .Account {
            return [
                "현금",
                "입출금",
                "저축",
                "대출",
                "카드",
                "체크카드",
                "투자",
                "마이너스 통장",
                "보험",
                "기타"
            ]
        }
        if type == .Income {
            return [
                "입금1",
                "입금2",
                "입금3"
            ]
        }
        if type == .Expense {
            return [
                "출금1",
                "출금2",
                "출금3"
            ]
        }
        return nil
    }
    
    func fetchCategories(groupId groupId: NSNumber, type: CategoryType) -> (categories: [Category]?, error: NSError?) {
        let predicateFormats = [
            "\(Category.PropertyName.groupId) = \(groupId)",
            "\(Category.PropertyName.type) = \(type.rawValue)"
        ]
        let predicate = NSPredicate(format: predicateFormats.joinWithSeparator(NSPredicate.joinSeparator), argumentArray: nil)
        let sortDescriptors = [ NSSortDescriptor(key: Category.PropertyName.order, ascending: true) ]
        return fetchObjects(objectType: Category.self, predicate: predicate, sortDescriptors: sortDescriptors)
    }
    
    func addDefaultCategorys(groupId groupId: NSNumber, type: CategoryType) -> (category: [Category]?, error: NSError?) {
        let names = defaultCategoryNames(type)
        let predicateFormats = [
            "\(Category.PropertyName.groupId) = \(groupId)",
            "\(Category.PropertyName.type) = \(type.rawValue)"
        ]
        let predicate = NSPredicate(format: predicateFormats.joinWithSeparator(NSPredicate.joinSeparator), argumentArray: nil)
        return addObjects(count: names!.count, objectType: Category.self, predicateForId: predicate) { (index, object, id) -> Void in
            
            object.id = index
            object.groupId = groupId
            object.type = type.rawValue
            object.name = names![index]
            object.order = index
        }
    }
    
    func addCategory(groupId groupId: NSNumber, type: CategoryType, name: String, order: NSInteger) -> (category: Category?, error: NSError?) {
        let predicateFormats = [
            "\(Category.PropertyName.groupId) = \(groupId)",
            "\(Category.PropertyName.type) = \(type.rawValue)"
        ]
        let predicate = NSPredicate(format: predicateFormats.joinWithSeparator(NSPredicate.joinSeparator), argumentArray: nil)
        return addObject(objectType: Category.self, predicateForId: predicate) { (object, id) -> Void in
            
            object.id = id
            object.groupId = groupId
            object.type = type.rawValue
            object.name = name
            object.order = order
        }
    }
    
    func removeCategorys(groupId groupId: NSNumber, type: CategoryType) -> NSError? {
        let predicateFormats = [
            "\(Category.PropertyName.groupId) = \(groupId)",
            "\(Category.PropertyName.type) = \(type.rawValue)"
        ]
        let predicate = NSPredicate(format: predicateFormats.joinWithSeparator(NSPredicate.joinSeparator), argumentArray: nil)
        return removeObjects(objectType: Category.self, predicate: predicate)
    }
    
    func removeCategory(category: Category) -> NSError? {
        return removeObject(category)
    }
}
