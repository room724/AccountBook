//
//  AccountViewController.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 3..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var outcomeLabel: UILabel!
    @IBOutlet weak var modeCalendarButton: UIButton!
    @IBOutlet weak var modeListButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        
        let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("AccountModeCalendarViewController")// as! AccountModeCalendarViewController
        
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
        addChildViewController(vc)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
