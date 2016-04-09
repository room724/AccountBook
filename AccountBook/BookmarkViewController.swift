//
//  BookmarkViewController.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 28..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

class BookmarkViewController : UITableViewController {

    var accounts: [Account]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchAccounts()
    }
    
    func fetchAccounts() {
        let (accounts, error) = CORE_DATA_MANAGER.fetchBookmarkAccounts()
        
        if error != nil {
            print("\(__FUNCTION__) error : \(error)")
            return
        }
        
        self.accounts = accounts
        self.tableView.reloadData()
    }
    
    // MARK: - HomeViewController
    
    override func didSelectInHomeViewController() {
        tableView.setContentOffsetAsContentInset(animated: false)
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookmarkViewCell", forIndexPath: indexPath) as! BookmarkViewCell
        let account = accounts![indexPath.row]
        
        cell.account = account
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "AccountViewController") {
            let accountViewController = segue.destinationViewController as! AccountViewController
            accountViewController.account = accounts![tableView.indexPathForSelectedRow!.row]
        }
    }
}
