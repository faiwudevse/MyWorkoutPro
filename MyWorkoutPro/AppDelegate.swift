//
//  AppDelegate.swift
//  MyWorkoutPro
//
//  Created by Fai Wu on 12/2/17.
//  Copyright © 2017 Fai Wu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let stack = CoreDataStack(modelName: "Model")!
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let defaults = UserDefaults.standard
        let isPreloaded = defaults.bool(forKey: "isPreloaded")
        if !isPreloaded {
            Client.sharedInstance().preloadData()
            defaults.set(true, forKey: "isPreloaded")
        }
        return true
    }

}

