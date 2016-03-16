//
//  AppDefines.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 12..
//  Copyright © 2016년 room724. All rights reserved.
//

import Foundation

enum TransactionType : Int32 {
    
    case Income
    case Expense
    case Transfer
}

enum PaymentType : Int32 {
    
    case Cash
    case CardCheck
    case CardCredit
}
