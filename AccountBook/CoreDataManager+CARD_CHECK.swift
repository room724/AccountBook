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
    
    func fetchCheckCards(groupId groupId: NSNumber) -> (cards: [CARD_CHECK]?, error: NSError?) {
        let predicate = NSPredicate(format: "\(CARD_CHECK.PROP_NAME.GROUP_ID) = \(groupId)", argumentArray: nil)
        return fetchObjects(objectType: CARD_CHECK.self, predicate: predicate, sortDescriptors: nil)
    }
    
    func addCheckCard(groupID groupId: NSNumber, name: String, order: NSInteger) -> (card: CARD_CHECK?, error: NSError?) {
        let predicate = NSPredicate(format: "\(CARD_CHECK.PROP_NAME.GROUP_ID) = \(groupId)", argumentArray: nil)
        return addObject(objectType: CARD_CHECK.self, predicateForId: predicate) { (object, id) -> Void in
            
            object.id = id
            object.group_id = groupId
            object.name = name
            object.order = order
        }
    }
}
