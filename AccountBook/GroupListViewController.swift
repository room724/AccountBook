//
//  GroupListViewController.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 3..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

class GroupListViewController: UITableViewController {

    var groups: [GROUP]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchGroups()
    }
    
    func fetchGroups() {
        CoreDataManager.sharedManager.fetchGroups { (groups, error) in
            if error != nil {
                print("\(__FUNCTION__) error : \(error)")
                return
            }
            
            self.groups = groups
            self.tableView.reloadData()
        }
    }
    
    @IBAction func addButtonTapped(sender: UIButton) {
        let order = groups?.count ?? 0
        let (group, error) = CoreDataManager.sharedManager.addGroup(name: "ABC", order: order)
        
        if (error != nil) {
            print("\(__FUNCTION__) error : \(error)")
            return
        }
        
        if groups == nil {
            groups = [ group! ]
        } else {
            groups!.append(group!)
        }
        
        tableView.insertRowsAtIndexPaths([ NSIndexPath(forRow: order, inSection: 0) ], withRowAnimation: .None)
    }
    
    // MARK: - HomeViewController
    
    override func didSelectInHomeViewController() {
        tableView.setContentOffsetAsContentInset(animated: false)
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GroupListViewCell", forIndexPath: indexPath) as! GroupListViewCell
        let group = groups![indexPath.row]
        
        cell.nameLabel.text = group.name
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            let group = groups![indexPath.row]
            
            if let error = CoreDataManager.sharedManager.removeGroup(group) {
                print("\(__FUNCTION__) error : \(error)")
                return
            }
            
            groups!.removeAtIndex(groups!.indexOf(group)!)
            tableView.deleteRowsAtIndexPaths([ NSIndexPath(forRow: indexPath.row, inSection: 0) ], withRowAnimation: .None)
        }
        else if (editingStyle == .Insert) {
            //
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "GroupViewController") {
            let groupViewController = segue.destinationViewController as! GroupViewController
            let group = groups![tableView.indexPathForSelectedRow!.row]
            groupViewController.groupId = group.id
        }
    }
}
