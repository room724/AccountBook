//
//  NSPredicate+Format.swift
//  AccountBook
//
//  Created by inock on 2016. 4. 13..
//  Copyright © 2016년 room724. All rights reserved.
//

import Foundation

extension NSPredicate {
    
    static var joinSeparator: String {
        get {
            return " AND "
        }
    }
}
