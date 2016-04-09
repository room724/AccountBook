//
//  CoreDataManager+CheckCard.swift
//  AccountBook
//
//  Created by inock on 2016. 4. 6..
//  Copyright © 2016년 room724. All rights reserved.
//

import CoreData
import Foundation

extension CoreDataManager {
    
    func defaultCheckCardNames() -> [String] {
        return [ "체크카드", "체크카드_테스트" ]
    }
    
    func fetchCheckCards(groupId groupId: NSNumber) -> (cards: [CheckCard]?, error: NSError?) {
        let predicate = NSPredicate(format: "\(CheckCard.PropertyName.groupId) = \(groupId)", argumentArray: nil)
        return fetchObjects(objectType: CheckCard.self, predicate: predicate, sortDescriptors: nil)
    }
    
    func addDefaultCheckCards(groupId groupId: NSNumber) -> (card: [CheckCard]?, error: NSError?) {
        let names = defaultCheckCardNames()
        let predicate = NSPredicate(format: "\(CheckCard.PropertyName.groupId) = \(groupId)", argumentArray: nil)
        return addObjects(count: names.count, objectType: CheckCard.self, predicateForId: predicate) { (index, object, id) -> Void in
            
            object.id = index
            object.groupId = groupId
            object.name = names[index]
            object.order = index
        }
    }
    
    func addCheckCard(groupId groupId: NSNumber, name: String, order: NSInteger) -> (card: CheckCard?, error: NSError?) {
        let predicate = NSPredicate(format: "\(CheckCard.PropertyName.groupId) = \(groupId)", argumentArray: nil)
        return addObject(objectType: CheckCard.self, predicateForId: predicate) { (object, id) -> Void in
            
            object.id = id
            object.groupId = groupId
            object.name = name
            object.order = order
        }
    }
    
    func removeCheckCards(groupId groupId: NSNumber) -> NSError? {
        let predicate = NSPredicate(format: "\(CheckCard.PropertyName.groupId) = \(groupId)", argumentArray: nil)
        return removeObjects(objectType: CheckCard.self, predicate: predicate)
    }
    
    func removeCheckCard(card: CheckCard) -> NSError? {
        return removeObject(card)
    }
}
