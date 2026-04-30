//
//  AppDelegate.swift
//  The-Cat-App
//
//  Created by Saúl Pérez on 30/04/26.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: BreedSelectionViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
