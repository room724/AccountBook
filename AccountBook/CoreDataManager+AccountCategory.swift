//
//  CoreDataManager+AccountCategory.swift
//  AccountBook
//
//  Created by inock on 2016. 4. 6..
//  Copyright © 2016년 room724. All rights reserved.
//

import CoreData
import Foundation

extension CoreDataManager {
    
    func defaultAccountCategoryNames() -> [String] {
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
    
    func fetchAccountCategories(groupId groupId: NSNumber) -> (categories: [AccountCategory]?, error: NSError?) {
        let predicate = NSPredicate(format: "\(AccountCategory.PropertyName.groupId) = \(groupId)", argumentArray: nil)
        return fetchObjects(objectType: AccountCategory.self, predicate: predicate, sortDescriptors: nil)
    }
    
    func addDefaultAccountCategorys(groupId groupId: NSNumber) -> (category: [AccountCategory]?, error: NSError?) {
        let names = defaultAccountCategoryNames()
        let predicate = NSPredicate(format: "\(AccountCategory.PropertyName.groupId) = \(groupId)", argumentArray: nil)
        return addObjects(count: names.count, objectType: AccountCategory.self, predicateForId: predicate) { (index, object, id) -> Void in
            
            object.id = index
            object.groupId = groupId
            object.name = names[index]
            object.order = index
        }
    }
    
    func addAccountCategory(groupId groupId: NSNumber, name: String, order: NSInteger) -> (category: AccountCategory?, error: NSError?) {
        let predicate = NSPredicate(format: "\(AccountCategory.PropertyName.groupId) = \(groupId)", argumentArray: nil)
        return addObject(objectType: AccountCategory.self, predicateForId: predicate) { (object, id) -> Void in
            
            object.id = id
            object.groupId = groupId
            object.name = name
            object.order = order
        }
    }
    
    func removeAccountCategorys(groupId groupId: NSNumber) -> NSError? {
        let predicate = NSPredicate(format: "\(AccountCategory.PropertyName.groupId) = \(groupId)", argumentArray: nil)
        return removeObjects(objectType: AccountCategory.self, predicate: predicate)
    }
    
    func removeAccountCategory(category: AccountCategory) -> NSError? {
        return removeObject(category)
    }
}
