//
//  CoreDataManager+CARD_CHECK.swift
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
    
    func fetchCheckCards(groupId groupId: NSNumber) -> (cards: [CARD_CHECK]?, error: NSError?) {
        let predicate = NSPredicate(format: "\(CARD_CHECK.PROP_NAME.GROUP_ID) = \(groupId)", argumentArray: nil)
        return fetchObjects(objectType: CARD_CHECK.self, predicate: predicate, sortDescriptors: nil)
    }
    
    func addDefaultCheckCards(groupId groupId: NSNumber) -> (card: [CARD_CHECK]?, error: NSError?) {
        let names = defaultCheckCardNames()
        let predicate = NSPredicate(format: "\(CARD_CHECK.PROP_NAME.GROUP_ID) = \(groupId)", argumentArray: nil)
        return addObjects(count: names.count, objectType: CARD_CHECK.self, predicateForId: predicate) { (index, object, id) -> Void in
            
            object.id = index
            object.group_id = groupId
            object.name = names[index]
            object.order = index
        }
    }
    
    func addCheckCard(groupId groupId: NSNumber, name: String, order: NSInteger) -> (card: CARD_CHECK?, error: NSError?) {
        let predicate = NSPredicate(format: "\(CARD_CHECK.PROP_NAME.GROUP_ID) = \(groupId)", argumentArray: nil)
        return addObject(objectType: CARD_CHECK.self, predicateForId: predicate) { (object, id) -> Void in
            
            object.id = id
            object.group_id = groupId
            object.name = name
            object.order = order
        }
    }
    
    func removeCheckCards(groupId groupId: NSNumber) -> NSError? {
        let predicate = NSPredicate(format: "\(CARD_CHECK.PROP_NAME.GROUP_ID) = \(groupId)", argumentArray: nil)
        return removeObjects(objectType: CARD_CHECK.self, predicate: predicate)
    }
    
    func removeCheckCard(card: CARD_CHECK) -> NSError? {
        return removeObject(card)
    }
}
