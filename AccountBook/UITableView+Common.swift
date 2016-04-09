//
//  UITableView+Common.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 30..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

extension UITableView {
    
    func setContentOffsetAsContentInset(animated animated: Bool) {
        setContentOffset(CGPoint(x: contentInset.left, y: -contentInset.top), animated: animated)
    }
}
