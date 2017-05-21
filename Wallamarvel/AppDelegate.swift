//
//  AppDelegate.swift
//  Wallamarvel
//
//  Created by Juanjo García Villaescusa on 20/5/17.
//  Copyright © 2017 Juanjo García Villaescusa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // creates both master & detail modules
        guard let heroList = HeroListWireframe.createHeroListModule(),
            let detail = HeroDetailWireframe.createHeroDetailModule(forHero: nil) else {
                return false
        }
        
        // creates split controller
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        if let splitController = mainStoryboard.instantiateViewController(withIdentifier: "SplitViewController") as? UISplitViewController {
            
            splitController.delegate = self
            
            // assigns master & detail views
            let detailNavigationController = UINavigationController(rootViewController: detail)
            splitController.viewControllers = [heroList, detailNavigationController]
            
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = splitController
            window?.makeKeyAndVisible()
            
            return true
        }
        
        return false
    }
}

extension AppDelegate: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else {
            return false
        }
        
        guard let topAsDetailController = secondaryAsNavController.topViewController as? HeroDetailViewController,
            let presenter = topAsDetailController.presenter  else {
                return false
        }
        
        if presenter.hero == nil {
            return true
        }
        
        return false
    }
}

