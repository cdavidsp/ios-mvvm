//
//  AppDelegate.swift
//  CleanMVVM
//
//  Created by SOSA PEREZ Cesar on 18/03/2021.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        AppAppearance.setupAppearance()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()

        window?.rootViewController = navigationController
        
        if let postsViewController = Assembler.sharedAssembler.resolver.resolve(PostsTableViewController.self) {
            navigationController.pushViewController(postsViewController, animated: true)
        }
        
        window?.makeKeyAndVisible()
    
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        CoreDataStorage.shared.saveContext()
    }
}
