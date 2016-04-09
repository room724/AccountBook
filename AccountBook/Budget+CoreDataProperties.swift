//
//  Budget+CoreDataProperties.swift
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

extension Budget {

    @NSManaged var accountId: NSNumber?
    @NSManaged var categoryId: NSNumber?
    @NSManaged var groupId: NSNumber?
    @NSManaged var money: NSNumber?
    @NSManaged var type: NSNumber?

}
