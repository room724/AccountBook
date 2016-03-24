//
//  AccountGroupViewController.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 3..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

class AccountGroupViewController: UIViewController {
    
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var expenseLabel: UILabel!
    @IBOutlet weak var equityLabel: UILabel!
    @IBOutlet weak var debtLabel: UILabel!
    @IBOutlet weak var assetLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
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
        
        if let error = CoreDataManager.sharedManager.addGroup("ABC", order: order) {
            print("\(__FUNCTION__) error : \(error)")
            return;
        }
        
        self.tableView.insertRowsAtIndexPaths([ NSIndexPath(forRow: order, inSection: 0) ], withRowAnimation: .None)
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.sharedManager.groups?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AccountGroupViewCell", forIndexPath: indexPath) as! AccountGroupViewCell
        let group = CoreDataManager.sharedManager.groups![indexPath.row] as GROUP
        
        cell.nameLabel.text = group.name
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
