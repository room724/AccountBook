//
//  CoreDataDefines.swift
//  AccountBook
//
//  Created by inock on 2016. 4. 6..
//  Copyright © 2016년 room724. All rights reserved.
//

import Foundation

enum BudgetType : NSNumber {
    
    case Income  = 0
    case Expense = 1
}

enum CardType : NSNumber {
    
    case Credit = 0
    case Check  = 1
}

enum CategoryType : NSNumber {
    
    case Account = 0
    case Income  = 1
    case Expense = 2
}

enum TransactionType : NSNumber {
    
    case Income   = 0
    case Expense  = 1
    case Transfer = 2
}

enum WeekStartDay : NSNumber {
    
    case Sunday = 1
    case Monday = 2
}
