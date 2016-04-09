//
//  AccountBudgetViewController.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 31..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

class AccountBudgetViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    enum TypeControlIndex : NSInteger {
        
        case Income = 0
        case Expense
    }
    
    @IBOutlet weak var typeControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeControl.selectedSegmentIndex = TypeControlIndex.Expense.rawValue
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchList()
    }
    
    func fetchList() {
        var type: BUDGET_TYPE?
        
        if typeControl.selectedSegmentIndex == TypeControlIndex.Income.rawValue {
            type = .INCOME
        } else if typeControl.selectedSegmentIndex == TypeControlIndex.Expense.rawValue {
            type = .EXPENSE
        }
        
        //
    }
    
    @IBAction func typeControlValueChanged(sender: AnyObject) {
        fetchList()
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