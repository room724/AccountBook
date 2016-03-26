//
//  GroupViewController.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 3..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {
    
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var expenseLabel: UILabel!
    @IBOutlet weak var equityLabel: UILabel!
    @IBOutlet weak var debtLabel: UILabel!
    @IBOutlet weak var assetLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var groupId: NSNumber?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
    }
    
    @IBAction func addButtonTapped(sender: UIButton) {
        //
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GroupViewCell", forIndexPath: indexPath) as! GroupViewCell
        
        //
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            //
        }
        else if (editingStyle == .Insert) {
            //
        }
    }
    
}
