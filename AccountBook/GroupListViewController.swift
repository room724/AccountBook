//
//  GroupListViewController.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 3..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

class GroupListViewController: UITableViewController {

    var groups: [Group]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchGroups()
    }
    
    func fetchGroups() {
        let (groups, error) = CORE_DATA_MANAGER.fetchGroups()
        
        if error != nil {
            print("\(__FUNCTION__) error : \(error)")
            return
        }
        
        self.groups = groups
        self.tableView.reloadData()
    }
    
    func showActionSheetForRemoveGroup(group: Group) {
        let accountCount = CORE_DATA_MANAGER.fetchAccountCount(groupId: group.id!).count
        let message = "\(accountCount)개의 계좌가 존재합니다. 함께 삭제하시겠습니까?"
        let actionSheet = UIAlertController(title: nil, message: message, preferredStyle: .ActionSheet)
        
        let removeAction = UIAlertAction(title: "전체 삭제", style: .Default) { action in
            self.removeGroup(group)
        }
        
        let moveAction = UIAlertAction(title: "다른 그룹으로 계좌 이동", style: .Default) { action in
            self.showActionSheetForMoveGroup(group)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .Cancel) { action in
            self.tableView.setEditing(false, animated: true)
        }
        
        actionSheet.addAction(removeAction)
        actionSheet.addAction(moveAction)
        actionSheet.addAction(cancelAction)
        
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showActionSheetForMoveGroup(group: Group) {
        
    }
    
    func addGroup() {
        let order = groups?.count ?? 0
        let (group, error) = CORE_DATA_MANAGER.addGroup(name: "ABC", order: order)
        
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
    
    func removeGroup(group: Group) {
        if let error = CORE_DATA_MANAGER.removeGroup(group) {
            print("\(__FUNCTION__) error : \(error)")
            return
        }
        
        let index = groups!.indexOf(group)!
        groups!.removeAtIndex(index)
        tableView.deleteRowsAtIndexPaths([ NSIndexPath(forRow: index, inSection: 0) ], withRowAnimation: .None)
    }
    
    func moveGroup(group: Group, toGroup: Group) {
        
    }
    
    @IBAction func addButtonTapped(sender: UIButton) {
        addGroup()
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
        let cell = tableView.dequeueReusableCellWithIdentifier(String(GroupListViewCell.self), forIndexPath: indexPath) as! GroupListViewCell
        let group = groups![indexPath.row]
        
        cell.group = group
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            let group = groups![indexPath.row]
            
            if groups!.count > 1 && CORE_DATA_MANAGER.fetchAccountCount(groupId: group.id!).count > 0 {
                showActionSheetForRemoveGroup(group)
            }
            else {
                removeGroup(group)
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == String(GroupViewController.self)) {
            let groupViewController = segue.destinationViewController as! GroupViewController
            groupViewController.group = groups![tableView.indexPathForSelectedRow!.row]
        }
    }
}
