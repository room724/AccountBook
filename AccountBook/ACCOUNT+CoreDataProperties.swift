//
//  ACCOUNT+CoreDataProperties.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 26..
//  Copyright © 2016년 room724. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ACCOUNT {

    @NSManaged var carryover: NSNumber?
    @NSManaged var favorite: NSNumber?
    @NSManaged var memo: String?
    @NSManaged var month_start_date: NSNumber?
    @NSManaged var name: String?
    @NSManaged var order: NSNumber?
    @NSManaged var week_start_day: NSNumber?
    @NSManaged var category_id: NSNumber?
    @NSManaged var id: NSNumber?
    @NSManaged var group_id: NSNumber?

}
