//
//  CoreDataManager+CreditCard.swift
//  AccountBook
//
//  Created by inock on 2016. 4. 9..
//  Copyright © 2016년 room724. All rights reserved.
//

import CoreData
import Foundation

extension CoreDataManager {
    
    func defaultCreditCardNames() -> [String] {
        return [ "신용카드", "신용카드_테스트" ]
    }
    
    func fetchCreditCards(groupId groupId: NSNumber) -> (cards: [CreditCard]?, error: NSError?) {
        let predicate = NSPredicate(format: "\(CreditCard.PropertyName.groupId) = \(groupId)", argumentArray: nil)
        return fetchObjects(objectType: CreditCard.self, predicate: predicate, sortDescriptors: nil)
    }
    
    func addDefaultCreditCards(groupId groupId: NSNumber) -> (card: [CreditCard]?, error: NSError?) {
        let names = defaultCreditCardNames()
        let predicate = NSPredicate(format: "\(CreditCard.PropertyName.groupId) = \(groupId)", argumentArray: nil)
        return addObjects(count: names.count, objectType: CreditCard.self, predicateForId: predicate) { (index, object, id) -> Void in
            
            object.id = index
            object.groupId = groupId
            object.name = names[index]
            object.order = index
        }
    }
    
    func addCreditCard(groupId groupId: NSNumber, name: String, order: NSInteger) -> (card: CreditCard?, error: NSError?) {
        let predicate = NSPredicate(format: "\(CreditCard.PropertyName.groupId) = \(groupId)", argumentArray: nil)
        return addObject(objectType: CreditCard.self, predicateForId: predicate) { (object, id) -> Void in
            
            object.id = id
            object.groupId = groupId
            object.name = name
            object.order = order
        }
    }
    
    func removeCreditCards(groupId groupId: NSNumber) -> NSError? {
        let predicate = NSPredicate(format: "\(CreditCard.PropertyName.groupId) = \(groupId)", argumentArray: nil)
        return removeObjects(objectType: CreditCard.self, predicate: predicate)
    }
    
    func removeCreditCard(card: CreditCard) -> NSError? {
        return removeObject(card)
    }
}