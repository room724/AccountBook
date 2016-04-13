//
//  CoreDataManager+Card.swift
//  AccountBook
//
//  Created by inock on 2016. 4. 6..
//  Copyright © 2016년 room724. All rights reserved.
//

import CoreData
import Foundation

extension CoreDataManager {
    
    func defaultCardNames(type: CardType) -> [String]? {
        if type == .Check {
            return [
                "체크카드",
                "체크카드_테스트"
            ]
        }
        if type == .Credit {
            return [
                "신용카드",
                "신용카드_테스트"
            ]
        }
        return nil
    }
    
    func fetchCards(groupId groupId: NSNumber, type: CardType) -> (cards: [Card]?, error: NSError?) {
        let predicateFormats = [
            "\(Card.PropertyName.groupId) = \(groupId)",
            "\(Card.PropertyName.type) = \(type.rawValue)"
        ]
        let predicate = NSPredicate(format: predicateFormats.joinWithSeparator(" AND "), argumentArray: nil)
        return fetchObjects(objectType: Card.self, predicate: predicate, sortDescriptors: nil)
    }
    
    func addDefaultCards(groupId groupId: NSNumber, type: CardType) -> (card: [Card]?, error: NSError?) {
        let names = defaultCardNames(type)
        let predicateFormats = [
            "\(Card.PropertyName.groupId) = \(groupId)",
            "\(Card.PropertyName.type) = \(type.rawValue)"
        ]
        let predicate = NSPredicate(format: predicateFormats.joinWithSeparator(" AND "), argumentArray: nil)
        return addObjects(count: names!.count, objectType: Card.self, predicateForId: predicate) { (index, object, id) -> Void in
            
            object.id = index
            object.groupId = groupId
            object.type = type.rawValue
            object.name = names![index]
            object.order = index
        }
    }
    
    func addCard(groupId groupId: NSNumber, type: CardType, name: String, order: NSInteger) -> (card: Card?, error: NSError?) {
        let predicateFormats = [
            "\(Card.PropertyName.groupId) = \(groupId)",
            "\(Card.PropertyName.type) = \(type.rawValue)"
        ]
        let predicate = NSPredicate(format: predicateFormats.joinWithSeparator(" AND "), argumentArray: nil)
        return addObject(objectType: Card.self, predicateForId: predicate) { (object, id) -> Void in
            
            object.id = id
            object.groupId = groupId
            object.type = type.rawValue
            object.name = name
            object.order = order
        }
    }
    
    func removeCards(groupId groupId: NSNumber, type: CardType) -> NSError? {
        let predicateFormats = [
            "\(Card.PropertyName.groupId) = \(groupId)",
            "\(Card.PropertyName.type) = \(type.rawValue)"
        ]
        let predicate = NSPredicate(format: predicateFormats.joinWithSeparator(" AND "), argumentArray: nil)
        return removeObjects(objectType: Card.self, predicate: predicate)
    }
    
    func removeCard(card: Card) -> NSError? {
        return removeObject(card)
    }
}
