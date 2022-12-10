//
//  AppDelegate.swift
//  JetDevsHomeWork
//
//  Created by Gary.yao on 2021/10/29.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    class func sharedDelegate () -> AppDelegate {
        return (UIApplication.shared.delegate as? AppDelegate)!
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: screenFrame)
        window?.rootViewController = BaseTabBarController()
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    // MARK: - Shared Function
    
    func gotoLoginScreen() {
        let nextVC = LoginViewController()
        window?.rootViewController = nextVC
        window?.makeKeyAndVisible()
    }
    func gotoTabScreen() {
        let nextVC = BaseTabBarController()
        nextVC.selectedIndex = 1
        window?.rootViewController = nextVC
        window?.makeKeyAndVisible()
    }
}
