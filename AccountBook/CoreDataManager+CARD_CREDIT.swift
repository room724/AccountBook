//
//  CoreDataManager+CARD_CREDIT.swift
//  AccountBook
//
//  Created by inock on 2016. 4. 9..
//  Copyright © 2016년 room724. All rights reserved.
//

import CoreData
import Foundation

extension CoreDataManager {
    
    func fetchCreditCards(groupId groupId: NSNumber) -> (cards: [CARD_CREDIT]?, error: NSError?) {
        let predicate = NSPredicate(format: "\(CARD_CREDIT.PROP_NAME.GROUP_ID) = \(groupId)", argumentArray: nil)
        return fetchObjects(objectType: CARD_CREDIT.self, predicate: predicate, sortDescriptors: nil)
    }
    
    func addCreditCard(groupID groupId: NSNumber, name: String, order: NSInteger) -> (card: CARD_CREDIT?, error: NSError?) {
        let predicate = NSPredicate(format: "\(CARD_CREDIT.PROP_NAME.GROUP_ID) = \(groupId)", argumentArray: nil)
        return addObject(objectType: CARD_CREDIT.self, predicateForId: predicate) { (object, id) -> Void in
            
            object.id = id
            object.group_id = groupId
            object.name = name
            object.order = order
        }
    }
}