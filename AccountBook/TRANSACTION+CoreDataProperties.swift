//
//  TRANSACTION+CoreDataProperties.swift
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

extension TRANSACTION {

    @NSManaged var date: NSDate?
    @NSManaged var memo: String?
    @NSManaged var money: NSNumber?
    @NSManaged var name: String?
    @NSManaged var payment_type: NSNumber?
    @NSManaged var type: NSNumber?
    @NSManaged var account: ACCOUNT?
    @NSManaged var account_from: ACCOUNT?
    @NSManaged var card_check: CARD_CHECK?
    @NSManaged var card_credit: CARD_CREDIT?
    @NSManaged var category_account: CATEGORY_ACCOUNT?
    @NSManaged var category_expense: CATEGORY_EXPENSE?
    @NSManaged var category_income: CATEGORY_INCOME?

}
