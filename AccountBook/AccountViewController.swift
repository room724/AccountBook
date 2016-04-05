//
//  AccountViewController.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 3..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    enum ModeControlIndex : NSInteger {
        
        case Calendar = 0
        case List
        case Budget
        
        var description: String {
            switch self {
                case .Calendar : return "Calendar"
                case .List     : return "List"
                case .Budget   : return "Budget"
            }
        }
    }
    
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var expenseLabel: UILabel!
    @IBOutlet weak var expenseCashLabel: UILabel!
    @IBOutlet weak var expenseCardLabel: UILabel!
    @IBOutlet weak var modeControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    var account: ACCOUNT?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modeControl.selectedSegmentIndex = ModeControlIndex.Calendar.rawValue
        updateModeView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchAccountDetailInfos()
    }
    
    func updateModeView() {
        if let viewController = childViewControllers.first {
            viewController.removeFromParentViewController()
            viewController.view.removeFromSuperview()
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewControllerId: String = "Account\(ModeControlIndex(rawValue: modeControl.selectedSegmentIndex)!.description)ViewController"
        let viewController = storyBoard.instantiateViewControllerWithIdentifier(viewControllerId)
        
        viewController.view.frame = containerView.bounds
        containerView.addSubview(viewController.view)
        addChildViewController(viewController)
    }
    
    func fetchAccountDetailInfos() {
        
        
        
        
        
    }
    
    @IBAction func modeControlValueChanged(sender: AnyObject) {
        updateModeView()
    }
}
