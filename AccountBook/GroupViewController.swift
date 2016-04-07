//
//  GroupViewController.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 3..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, GroupViewCellDelegate {
    
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var expenseLabel: UILabel!
    @IBOutlet weak var equityLabel: UILabel!
    @IBOutlet weak var debtLabel: UILabel!
    @IBOutlet weak var assetLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var group: GROUP?
    var accounts: [ACCOUNT]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchAccounts()
    }
    
    func fetchAccounts() {
        CORE_DATA_MANAGER.fetchAccounts(groupId: group!.id!) { (accounts, error) in
            if error != nil {
                print("\(__FUNCTION__) error : \(error)")
                return
            }
            
            self.accounts = accounts
            self.tableView.reloadData()
        }
    }
    
    func addAccount() {
        let order = accounts?.count ?? 0
        let (account, error) = CORE_DATA_MANAGER.addAccount(groupId: group!.id!, name: "ABC", order: order)
        
        if (error != nil) {
            print("\(__FUNCTION__) error : \(error)")
            return
        }
        
        if accounts == nil {
            accounts = [ account! ]
        } else {
            accounts!.append(account!)
        }
        
        tableView.insertRowsAtIndexPaths([ NSIndexPath(forRow: order, inSection: 0) ], withRowAnimation: .None)
    }
    
    func removeAccount(account: ACCOUNT) {
        if let error = CORE_DATA_MANAGER.removeAccount(account) {
            print("\(__FUNCTION__) error : \(error)")
            return
        }
        
        let index = accounts!.indexOf(account)!
        accounts!.removeAtIndex(index)
        tableView.deleteRowsAtIndexPaths([ NSIndexPath(forRow: index, inSection: 0) ], withRowAnimation: .None)
    }
    
    @IBAction func addButtonTapped(sender: UIButton) {
        addAccount()
    }
    
    // MARK: - HomeViewController
    
    override func didSelectInHomeViewController() {
        tableView.setContentOffsetAsContentInset(animated: false)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GroupViewCell", forIndexPath: indexPath) as! GroupViewCell
        let account = accounts![indexPath.row]
        
        cell.account  = account
        cell.delegate = self
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            removeAccount(accounts![indexPath.row])
        }
    }
    
    // MARK: - GroupViewCellDelegate
    
    func bookmarkButtonTappedInGroupViewCell(groupViewCell: GroupViewCell) {
        let account = groupViewCell.account!
        let bookmark = account.bookmark?.boolValue ?? false
        
        account.bookmark = NSNumber(bool: !bookmark)
        
        if let error = CORE_DATA_MANAGER.save() {
            print("\(__FUNCTION__) error : \(error)")
            return
        }
        
        groupViewCell.account = account
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "AccountViewController") {
            let accountViewController = segue.destinationViewController as! AccountViewController
            accountViewController.account = accounts![tableView.indexPathForSelectedRow!.row]
        }
    }
}
