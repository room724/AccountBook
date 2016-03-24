//
//  AccountGroupListViewController.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 3..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

class AccountGroupListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoreDataManager.sharedManager.fetchGroups { error in
            if error != nil {
                print("\(__FUNCTION__) error : \(error)")
                return;
            }
            
            self.tableView.reloadData()
        }
    }
    
    @IBAction func addButtonTapped(sender: UIButton) {
        let order = CoreDataManager.sharedManager.groups!.count
        CoreDataManager.sharedManager.addGroup("ABC", order: order)
        tableView.insertRowsAtIndexPaths([ NSIndexPath(forRow: order, inSection: 0) ], withRowAnimation: .None)
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.sharedManager.groups?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AccountGroupListViewCell", forIndexPath: indexPath) as! AccountGroupListViewCell
        let group = CoreDataManager.sharedManager.groups![indexPath.row] as GROUP
        
        cell.nameLabel.text = group.name
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let group = CoreDataManager.sharedManager.groups![indexPath.row]
            CoreDataManager.sharedManager.removeGroup(group)
            tableView.deleteRowsAtIndexPaths([ NSIndexPath(forRow: indexPath.row, inSection: 0) ], withRowAnimation: .None)
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "AccountGroupViewController") {
            let indexPath = tableView.indexPathForSelectedRow!
            let viewController = segue.destinationViewController as! AccountGroupViewController
            viewController.groupObjectID = CoreDataManager.sharedManager.groups![indexPath.row].objectID
        }
    }
    
}
