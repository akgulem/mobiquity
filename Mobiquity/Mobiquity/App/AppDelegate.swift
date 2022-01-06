//
//  AppDelegate.swift
//  Mobiquity
//
//  Created by Emrah Akgül on 5.01.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        let searchViewController = SearchViewRouter.createModule(using: navigationController)
        window?.rootViewController = searchViewController
        window?.makeKeyAndVisible()
        return true
    }
}
