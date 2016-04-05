//
//  AccountCalendarViewController.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 12..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

class AccountCalendarViewController : UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var transactions: [TRANSACTION]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AccountCalendarViewCell", forIndexPath: indexPath) as! AccountCalendarViewCell
        
        //
        
        return cell
    }
}
