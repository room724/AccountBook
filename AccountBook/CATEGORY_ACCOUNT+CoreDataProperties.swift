//
//  CATEGORY_ACCOUNT+CoreDataProperties.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 17..
//  Copyright © 2016년 room724. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension CATEGORY_ACCOUNT {

    @NSManaged var name: String?
    @NSManaged var order: NSNumber?

}
