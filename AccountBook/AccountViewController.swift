//
//  AccountViewController.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 3..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

enum AccountViewMode : NSString {
    
    case Undefinded
    case Calendar
    case List
}

class AccountViewController: UIViewController {
    
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var expenseLabel: UILabel!
    @IBOutlet weak var modeCalendarButton: UIButton!
    @IBOutlet weak var modeListButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    var mode: AccountViewMode = .Undefinded
    var accountId: NSNumber?
    var transactions: [TRANSACTION]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeViewMode(.Calendar)
        self.fetchTransactions()
    }
    
    func changeViewMode(mode: AccountViewMode) {
        if self.mode == mode {
            return
        }
        
        self.mode = mode
        
        modeCalendarButton.selected = (mode == .Calendar)
        modeListButton.selected = (mode == .List)
        
        if let viewController = childViewControllers.first {
            viewController.removeFromParentViewController()
            viewController.view.removeFromSuperview()
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewControllerId: String = "Account\(mode.rawValue)ViewController"
        let viewController = storyBoard.instantiateViewControllerWithIdentifier(viewControllerId)
        
        viewController.view.frame = containerView.bounds
        containerView.addSubview(viewController.view)
        addChildViewController(viewController)
    }
    
    func fetchTransactions() {
        
    }
    
    @IBAction func modeCalendarButtonTapped(sender: AnyObject) {
        changeViewMode(.Calendar)
    }
    
    @IBAction func modeListButtonTapped(sender: AnyObject) {
        changeViewMode(.List)
    }
}
