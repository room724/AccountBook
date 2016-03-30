//
//  BUDGET+CoreDataProperties.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 31..
//  Copyright © 2016년 room724. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension BUDGET {

    @NSManaged var account_id: NSNumber?
    @NSManaged var id: NSNumber?
    @NSManaged var category_id: NSNumber?
    @NSManaged var money: NSNumber?
    @NSManaged var type: NSNumber?

}
