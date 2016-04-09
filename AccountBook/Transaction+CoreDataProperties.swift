//
//  Transaction+CoreDataProperties.swift
//  AccountBook
//
//  Created by inock on 2016. 4. 10..
//  Copyright © 2016년 room724. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Transaction {

    @NSManaged var accountId: NSNumber?
    @NSManaged var cardId: NSNumber?
    @NSManaged var categoryId: NSNumber?
    @NSManaged var date: NSDate?
    @NSManaged var groupId: NSNumber?
    @NSManaged var id: NSNumber?
    @NSManaged var memo: String?
    @NSManaged var money: NSNumber?
    @NSManaged var name: String?
    @NSManaged var type: NSNumber?

}
