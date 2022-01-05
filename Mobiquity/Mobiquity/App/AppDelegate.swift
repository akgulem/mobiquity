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
        let viewController = UIViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }
}
