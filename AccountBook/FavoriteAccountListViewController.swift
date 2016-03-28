//
//  FavoriteAccountListViewController.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 28..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

class FavoriteAccountListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        //
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FavoriteAccountListViewCell", forIndexPath: indexPath) as! FavoriteAccountListViewCell
        
        //
        
        return cell
    }
}
