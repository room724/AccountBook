//
//  Account+CoreDataProperties.swift
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

extension Account {

    @NSManaged var bookmark: NSNumber?
    @NSManaged var carryover: NSNumber?
    @NSManaged var categoryId: NSNumber?
    @NSManaged var groupId: NSNumber?
    @NSManaged var id: NSNumber?
    @NSManaged var memo: String?
    @NSManaged var monthStartDate: NSNumber?
    @NSManaged var name: String?
    @NSManaged var order: NSNumber?
    @NSManaged var weekStartDay: NSNumber?

}
