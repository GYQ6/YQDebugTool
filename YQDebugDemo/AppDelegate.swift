//
//  AppDelegate.swift
//  YQDebugTool
//
//  Created by 郭宇琪 on 2020/11/13.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        let naVC = UINavigationController(rootViewController: ViewController())
        
        self.window?.rootViewController = naVC
        return true
    }
}

