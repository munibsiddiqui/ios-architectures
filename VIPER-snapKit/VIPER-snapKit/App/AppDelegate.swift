//
//  AppDelegate.swift
//  VIPER-snapKit
//
//  Created by GoEun Jeong on 2021/05/12.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appRouter: AppRouter?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        appRouter = AppRouter(networkingApi: NetworkingAPI(), navigationController: UINavigationController())
        window?.rootViewController = appRouter?.navigationController
        appRouter?.start()
        window?.makeKeyAndVisible()
        return true
    }
}


