//
//  AppDelegate.swift
//  TeeMapSwift
//
//  Created by Jonathan Kopp on 10/28/20.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let vc = ViewController()
        window!.rootViewController = vc
        window!.makeKeyAndVisible()
        return true
    }
}

