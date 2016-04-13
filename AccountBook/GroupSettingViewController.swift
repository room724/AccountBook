//
//  GroupSettingViewController.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 31..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

class GroupSettingViewController: UITableViewController {
    
    var groupId: NSNumber?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == String(CategoryListViewController.self)) {
            let categoryViewController = segue.destinationViewController as! CategoryListViewController
            categoryViewController.groupId = groupId!
            categoryViewController.categoryType = .Account // todo
        } else if (segue.identifier == String(CardListViewController.self)) {
            let cardViewController = segue.destinationViewController as! CardListViewController
            cardViewController.groupId = groupId!
            cardViewController.cardType = .Credit // todo
        }
    }
}