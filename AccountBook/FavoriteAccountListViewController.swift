//
//  FavoriteAccountListViewController.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 28..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

class FavoriteAccountListViewController: UITableViewController {

    var accounts: [ACCOUNT]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchAccounts()
    }
    
    func fetchAccounts() {
        CoreDataManager.sharedManager.fetchFavoriteAccounts { (accounts, error) in
            if error != nil {
                print("\(__FUNCTION__) error : \(error)")
                return
            }
            
            self.accounts = accounts
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        //
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FavoriteAccountListViewCell", forIndexPath: indexPath) as! FavoriteAccountListViewCell
        let account = accounts![indexPath.row]
        
        cell.account = account
        
        return cell
    }
}
