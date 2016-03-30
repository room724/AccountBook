//
//  AccountBudgetViewController.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 31..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

class AccountBudgetViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //
    }
    
    // MARK: - HomeViewController
    
    override func didSelectInHomeViewController() {
        segmentedControl.selectedSegmentIndex = 0
        tableView.setContentOffsetAsContentInset(animated: false)
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AccountBudgetViewCell", forIndexPath: indexPath) as! AccountBudgetViewCell
        
        //
        
        return cell
    }
}