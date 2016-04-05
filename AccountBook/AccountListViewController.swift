//
//  AccountListViewController.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 12..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

class AccountListViewController : UITableViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AccountListViewCell", forIndexPath: indexPath) as! AccountListViewCell
        
        //
        
        return cell
    }
}