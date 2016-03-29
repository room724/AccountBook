//
//  HomeViewController.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 29..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func didSelectInHomeViewController() {}
}

class HomeViewController : UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        if viewController.isKindOfClass(UINavigationController) {
            let navigationController = viewController as! UINavigationController
            navigationController.popToRootViewControllerAnimated(false)
            navigationController.viewControllers.first!.didSelectInHomeViewController()
        } else {
            viewController.didSelectInHomeViewController()
        }
    }
}
