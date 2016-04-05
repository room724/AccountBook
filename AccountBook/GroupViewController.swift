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
    
    var groupId: NSNumber?
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
        CoreDataManager.sharedManager.fetchAccountsWithGroupId(groupId!) { (accounts, error) in
            if error != nil {
                print("\(__FUNCTION__) error : \(error)")
                return
            }
            
            self.accounts = accounts
            self.tableView.reloadData()
        }
    }
    
    @IBAction func addButtonTapped(sender: UIButton) {
        let order = accounts?.count ?? 0
        let (account, error) = CoreDataManager.sharedManager.addAccountWithGroupId(groupId!, name: "ABC", order: order)
        
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
            let account = accounts![indexPath.row]
            
            if let error = CoreDataManager.sharedManager.removeAccount(account) {
                print("\(__FUNCTION__) error : \(error)")
                return
            }
            
            accounts!.removeAtIndex(accounts!.indexOf(account)!)
            tableView.deleteRowsAtIndexPaths([ NSIndexPath(forRow: indexPath.row, inSection: 0) ], withRowAnimation: .None)
        }
        else if (editingStyle == .Insert) {
            //
        }
    }
    
    // MARK : - GroupViewCellDelegate
    
    func favoriteButtonTappedInGroupViewCell(groupViewCell: GroupViewCell) {
        let account = groupViewCell.account!
        let favorite = account.favorite?.boolValue ?? false
        
        account.favorite = NSNumber(bool: !favorite)
        
        if let error = CoreDataManager.sharedManager.save() {
            print("\(__FUNCTION__) error : \(error)")
            return
        }
        
        groupViewCell.account = account
    }
}
