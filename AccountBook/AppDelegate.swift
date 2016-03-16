//
//  AppDelegate.swift
//  AccountBook
//
//  Created by inock on 2016. 3. 2..
//  Copyright © 2016년 room724. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        print(CoreDataManager.sharedManager.managedObjectContext)
        
        return true
    }

    func applicationWillTerminate(application: UIApplication) {
        CoreDataManager.sharedManager.saveContext()
    }
}
