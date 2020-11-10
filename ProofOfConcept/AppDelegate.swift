//
//  AppDelegate.swift
//  ProofOfConcept
//
//  Created by administrator on 09/11/20.
//  Copyright © 2020 administrator. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
      window = UIWindow(frame: UIScreen.main.bounds)
      let rootNC = UINavigationController(rootViewController: FactListViewController())
      window?.rootViewController = rootNC
      window?.makeKeyAndVisible()
        return true
    }

}

