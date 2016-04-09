//
//  CategoryAccountListViewController.swift
//  AccountBook
//
//  Created by inock on 2016. 4. 9..
//  Copyright © 2016년 room724. All rights reserved.
//

import Foundation
import UIKit

class CategoryAccountListViewController: UITableViewController {
    
    /*
    var groupId: NSNumber?
    var categories: [CATEGORY_ACCOUNT]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchCategories()
    }
    
    func fetchCategories() {
        let (categories, error) = CORE_DATA_MANAGER.fetchAccountCategories(groupId: group!.id!)
        
        if error != nil {
            print("\(__FUNCTION__) error : \(error)")
            return
        }
        
        self.categories = categories
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryAccountListViewCell", forIndexPath: indexPath) as! CategoryAccountListViewCell
        let category = categories![indexPath.row]
        
        //
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            //
        }
    }
    */
}
