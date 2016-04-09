//
//  CoreDataDefines.swift
//  AccountBook
//
//  Created by inock on 2016. 4. 6..
//  Copyright © 2016년 room724. All rights reserved.
//

import Foundation

enum BUDGET_TYPE : NSNumber {
    
    case INCOME  = 0
    case EXPENSE = 1
}

enum TRANSACTION_TYPE : NSNumber {
    
    case INCOME   = 0
    case EXPENSE  = 1
    case TRANSFER = 2
}

enum WEEK_START_DAY : NSNumber {
    
    case SUNDAY = 1
    case MONDAY = 2
}
